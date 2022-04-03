--
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

--	search
function onInit()
	OptionsManager.registerOption2(
					'PS-NONID-NAME', false, 'option_header_game', 'opt_lab_ps_nonidname', 'option_entry_cycler',
					{ labels = 'option_val_on', values = 'on', baselabel = 'option_val_off', baseval = 'off', default = 'off' }
	)
end
