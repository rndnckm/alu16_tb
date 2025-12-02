vlib work
vmap work work

#RTL
vlog -v src/74182_CLA.v \
		src/74181.v \
		src/top_alu_16.v

#Sim
vlog -sv -mfcu vrf/tb/include.svh \
			   vrf/tb/alu16_if.sv \
			   vrf/tb/alu_trans.sv \
			   vrf/seqs/alu_base_seq.sv \
			   vrf/tb/alu_driver.sv \
			   vrf/tb/alu_monitor.sv \
			   vrf/tb/alu_agent.sv \
			   vrf/tb/alu_scoreboard.sv \
			   vrf/tb/alu_env.sv \
			   vrf/tb/alu_test.sv \
			   vrf/tb/tb_top.sv
			   
		 
vsim -uvmcontrol=all -assertdebug alu_tb

run -all
