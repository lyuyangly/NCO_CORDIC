transcript off
# write transcript transcript
if {[file exist [project env]] > 0} {
project close
}
if {[file exist "./vsim.mpf"] == 0} {
  project new [pwd] vsim
} else	{
project open vsim
}
# Create default work directory if not present
if {[file exist work] ==0} 	{
  exec vlib work
  exec vmap work work
}

# Map lpm library
#if {[file exist lpm] ==0} 	{
#  exec vlib lpm
#  exec vmap lpm lpm}
#vlog -93 -work lpm $env(QUARTUS_ROOTDIR)/eda/sim_lib/220model.v

# Map altera_mf library
#if {[file exist altera_mf] ==0} 	{
#  exec vlib altera_mf
#  exec vmap altera_mf altera_mf}
#vlog -93 -work altera_mf $env(QUARTUS_ROOTDIR)/eda/sim_lib/altera_mf.v

# Map sgate library
if {[file exist sgate] ==0} 	{
  exec vlib sgate
  exec vmap sgate sgate}
vlog -93 -work sgate $env(QUARTUS_ROOTDIR)/eda/sim_lib/sgate.v

vlog ./cordic_cell.v
vlog ./cordic_pipelined.v
vlog ./nco.v
vlog ./nco_tb.v

vsim -L sgate -novopt nco_tb

do wave.do
run 10000 ns
