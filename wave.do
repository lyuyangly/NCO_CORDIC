transcript on
onerror {resume}
quietly WaveActivateNextPane {} 0
#add wave -noupdate -divider -height 30

add wave -noupdate -format Logic -radix binary /nco_tb/clk
add wave -noupdate -format Logic -radix binary /nco_tb/rst

add wave -noupdate -divider -height 100 {if waveform}
add wave -noupdate -color #00ff33 -format Analog_Auto -radix decimal /nco_tb/x_o
add wave -noupdate -divider -height 100 {if waveform}
add wave -noupdate -color #f00000 -format Analog_Auto -radix decimal /nco_tb/y_o
add wave -noupdate -divider -height 100 {if waveform}

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {356 ns}
WaveRestoreZoom {0 ns} {2132 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
