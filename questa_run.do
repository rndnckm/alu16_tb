vlib work
vmap work work

#RTL
vlog -v src/74182_CLA.v \
		src/74181.v \
		src/top_alu_16.v

#Sim
vlog -sv -mfcu vrf/include.svh \
			   vrf/alu16_if.sv \
			   vrf/alu_trans.sv \
			   vrf/alu_env.sv \
			   vrf/alu_test.sv \
			   vrf/tb_top.sv
		 
vsim -uvmcontrol=all -assertdebug alu_tb

run -all
