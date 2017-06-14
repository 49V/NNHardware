onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /fprop_tb/CLOCK_27_TB
add wave -noupdate -expand -group tb /fprop_tb/RESET_TB
add wave -noupdate -expand -group tb /fprop_tb/INPUTS_TB
add wave -noupdate -expand -group tb /fprop_tb/inputs2
add wave -noupdate -expand -group tb /fprop_tb/WEIGHTS_TB
add wave -noupdate -expand -group tb /fprop_tb/BIASES_TB
add wave -noupdate -expand -group tb /fprop_tb/outputs1
add wave -noupdate -expand -group tb /fprop_tb/OUTPUTS_TB
add wave -noupdate -expand -group layer1 /fprop_tb/layer1/CLOCK_27
add wave -noupdate -expand -group layer1 /fprop_tb/layer1/RESET
add wave -noupdate -expand -group layer1 /fprop_tb/layer1/INPUTS
add wave -noupdate -expand -group layer1 /fprop_tb/layer1/WEIGHTS
add wave -noupdate -expand -group layer1 /fprop_tb/layer1/BIASES
add wave -noupdate -expand -group layer1 /fprop_tb/layer1/OUTPUTS
add wave -noupdate -expand -group layer1 /fprop_tb/layer1/q
add wave -noupdate -expand -group layer1 /fprop_tb/layer1/prev_inputs
add wave -noupdate -expand -group layer2 /fprop_tb/layer2/CLOCK_27
add wave -noupdate -expand -group layer2 /fprop_tb/layer2/RESET
add wave -noupdate -expand -group layer2 /fprop_tb/layer2/INPUTS
add wave -noupdate -expand -group layer2 /fprop_tb/layer2/WEIGHTS
add wave -noupdate -expand -group layer2 /fprop_tb/layer2/BIASES
add wave -noupdate -expand -group layer2 /fprop_tb/layer2/OUTPUTS
add wave -noupdate -expand -group layer2 /fprop_tb/layer2/q
add wave -noupdate -expand -group layer2 /fprop_tb/layer2/prev_inputs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 221
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {928 ps}
