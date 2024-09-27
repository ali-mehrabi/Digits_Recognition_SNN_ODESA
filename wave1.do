onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /digits_network_tb/u_network/u_l1/i_clk
add wave -noupdate /digits_network_tb/u_network/u_l1/i_event
add wave -noupdate /digits_network_tb/u_network/u_l1/i_gas
add wave -noupdate -expand /digits_network_tb/u_network/u_l1/u_l1_train/i_lvl_spikeout
add wave -noupdate -expand /digits_network_tb/u_network/u_l1/u_l1_train/r_w
add wave -noupdate -expand -subitemconfig {{/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[10]} {-format Analog-Step -height 74 -max 523718.0 -min -524181.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[9]} {-format Analog-Step -height 74 -max 523829.0 -min -523856.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[8]} {-format Analog-Step -height 74 -max 522259.00000000012 -min -523332.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[7]} {-format Analog-Step -height 74 -max 509013.0 -min 8192.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[6]} {-format Analog-Step -height 74 -max 502465.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[5]} {-format Analog-Step -height 74 -max 470034.0 -min 8192.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[4]} {-format Analog-Step -height 74 -max 486455.0 -min 8192.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[3]} {-format Analog-Step -height 74 -max 521925.99999999988 -min -523482.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[2]} {-format Analog-Step -height 74 -max 523941.0 -min -523745.0} {/digits_network_tb/u_network/u_l1/u_l1_train/r_threshold[1]} {-format Analog-Step -height 74 -max 523469.0 -min -522460.0}} /digits_network_tb/u_network/u_l1/u_l1_train/r_threshold
add wave -noupdate /digits_network_tb/u_network/u_l1/u_l1_train/r_ts
add wave -noupdate /digits_network_tb/u_network/u_l1/u_l1_train/w_pass_l1
add wave -noupdate /digits_network_tb/u_network/u_l1/u_l1_train/r_training_active
add wave -noupdate /digits_network_tb/u_network/u_l1/u_l1_train/r_winner
add wave -noupdate /digits_network_tb/u_network/u_l1/u_l1_train/r_state
add wave -noupdate /digits_network_tb/u_network/u_l1/u_l1_train/r_stop_n
add wave -noupdate /digits_network_tb/u_network/u_l1/u_l1_train/r_counter
add wave -noupdate /digits_network_tb/u_network/u_l1/u_l1_train/r_gas
add wave -noupdate -divider L2
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/w_pass_l2
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_stop_n
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_winner
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_label
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_is_label
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_training_active
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_counter
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_ts
add wave -noupdate -expand -subitemconfig {{/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[10]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[9]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[8]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[7]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[6]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[5]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[4]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[3]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[2]} {-format Analog-Step -height 74 -max 500000.0} {/digits_network_tb/u_network/u_l2/u_l2_train/r_threshold[1]} {-format Analog-Step -height 74 -max 500000.0}} /digits_network_tb/u_network/u_l2/u_l2_train/r_threshold
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_w
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/r_state
add wave -noupdate /digits_network_tb/u_network/u_l2/u_l2_train/i_lv2_spikeout
add wave -noupdate -expand /digits_network_tb/u_network/u_l2/o_spike
add wave -noupdate -divider Trainer
add wave -noupdate -radix decimal /digits_network_tb/u_network/u_trainer/r_epochs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12514470 ns} 0} {{Cursor 2} {86585290 ns} 0} {{Cursor 3} {9371790 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 350
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {87948344 ns} {90581528 ns}
