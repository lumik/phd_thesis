# -*- coding: utf-8 -*-

import fileinput
import os
import re
import subprocess


def create_plots(file_name, working_dir, rel_dir):
	print('Plotting {}...'.format(os.path.join(rel_dir, file_name)))

	command = 'gnuplot -e "load \'{}\'"'.format(file_name)
	subprocess.call(command, shell=True, cwd=working_dir)


def convert_ps2pdf(file_name, working_dir, rel_dir):
	print('Converting {} to pdf...'.format(os.path.join(rel_dir, file_name)))

	fn_base = os.path.splitext(file_name)[0]
	command = 'ps2pdf -dEPSCrop {} {}.pdf'.format(file_name, fn_base)
	subprocess.call(command, shell=True, cwd=working_dir)
	print('Removing {}...'.format(os.path.join(rel_dir, file_name)))
	os.remove(os.path.join(working_dir, file_name))


def fix_include_path(file_name, working_dir, rel_dir):
	print('Fixing {} include path...'.format(os.path.join(rel_dir, file_name)))

	with open(os.path.join(working_dir, file_name), 'r') as f:
		tex_file = f.readlines()

	fn_base = os.path.splitext(file_name)[0]
	unix_path = os.path.join(rel_dir, fn_base).replace('\\', '/')
	original_include = 'includegraphics{{{}}}'.format(fn_base)
	replace_include = 'includegraphics{{{}}}'.format(unix_path)
	for i, line in enumerate(tex_file):
		if (line.find('includegraphics')):
			tex_file[i] = line.replace(original_include, replace_include)

	with open(os.path.join(working_dir, file_name), 'w') as f:
		f.writelines(tex_file)


def process_plots():
	plot_settings = [
		# relative directory                filename         outputs
		['results_and_discussion/assets/', 'focusing.gp', ['F.eps']],
		['results_and_discussion/assets/spectrograph_dispersion_meas/',
			'bounds_1200_range.gp', ['bounds_1200_range.eps']],
		['results_and_discussion/assets/spectrograph_dispersion_meas/',
			'bounds_2400_range.gp', ['bounds_2400_range.eps']],
		['results_and_discussion/assets/cyclohexane_calibration/',
			'cyclohexane_calibration.gp', ['cyclohexane_calibration.eps']],
		['results_and_discussion/assets/pt_calibration/',
			'pt_calibration.gp', ['pt_calibration.eps']]
	]

	root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

	for plot_list in plot_settings:
		plot_dir = plot_list[0]
		plot_file_name = plot_list[1]
		plot_outputs = plot_list[2]
		working_dir = os.path.normpath(os.path.join(root_dir, plot_dir))
		rel_dir = os.path.relpath(working_dir, root_dir)
		create_plots(plot_file_name, working_dir, rel_dir)

		for f in plot_outputs:
			convert_ps2pdf(f, working_dir, rel_dir)
			fn_base = os.path.splitext(f)[0]
			tex_file_name = '{}.tex'.format(fn_base)
			fix_include_path(tex_file_name, working_dir, rel_dir)


if __name__ == '__main__':
	process_plots()
