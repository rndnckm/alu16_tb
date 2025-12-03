# alu16_tb
Testbench for 74181 16-bit ALU verification

Запуск симуляции (QuestaSim 2021.1 64-bit):
vsim -c -do questa_run.do

Список тестов:

Арифметические
Add
AB minus 1
A minus B minus 1
Minus 1

Логические
AND
OR
XOR

Архитектура тестового окружения

├── src/ \
│   └── 74181.v                  # ALU 4-bit \
│   └── 74182_CLA.v              # Carry Look-Ahead Unit \
│   └── top_alu_16.v              # 16-bit ALU top module \
├── vrf/ \
│    └──tb/ \
│       ├── alu_trans.svh     # Sequence item \
│       ├── alu_driver.svh          # Driver \
│       ├── alu_monitor.svh         # Monitor \
│       ├── alu_scoreboard.svh      # Scoreboard \
│       ├── alu_agent.svh           # Agent \
│       ├── alu_env.svh             # Environment \
│       ├── alu_test.svh            # Test \
│       └── alu_if.sv               # Interface \
│    └──seqs/ \
│       └── alu_base_seq.sv               # Base Sequence \
│ questa_run.do 	#Скрипт для запуска симуляции
