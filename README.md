# AXI_VIP
This project demonstrates a reusable Universal Verification Component (UVC) developed using SystemVerilog and UVM for verifying AXI4 Master and Slave interfaces in accordance with the AMBA AXI protocol specification. The environment is modular, parameterized, and scalable, suitable for integration into larger SoC verification environments.

# Project Objective:
To design, develop, and verify a configurable and reusable AXI4 Master-Slave UVC, enabling:

Protocol-compliant transaction generation

Assertion-based error checking

Coverage-driven verification

# Tools & Technologies:
Language: SystemVerilog, UVM (Universal Verification Methodology)

Simulation: Synopsys VCS / Siemens QuestaSim

Protocol: AMBA AXI4 (Read & Write Transactions)

# UVC Architecture:
AXI Master Agent: Configurable to drive read/write transactions with variable burst types, sizes, and lengths.

AXI Slave Agent: Responds to AXI transactions with valid/ready handshakes and data responses.

Testbench Components: Environment, scoreboard, monitor, coverage, and sequences designed per UVM architecture.

Factory Overrides & Config DB: Used for flexible test control and component reuse.

# Key Features:
Developed stimulus generation sequences to verify different AXI scenarios like burst, single, and mixed transactions.

Implemented functional coverage and protocol assertions to ensure compliance.

Designed scoreboard with reference model for end-to-end data checking and error injection scenarios.

Achieved verification sign-off based on coverage closure and assertion-based validation.

# Learning Outcome:
In-depth understanding of UVM testbench components and hierarchy

Real-time experience in verifying AMBA AXI4 protocol-compliant DUTs

Hands-on experience with coverage-driven and assertion-based verification techniques

