 Smart Home Light Controller using Verilog

A smart home lighting controller designed using Verilog HDL.

Overview

This project controls a home light using manual and automatic modes.

In automatic mode, the light turns ON when motion is detected and the
environment is dark.

In manual mode, the user directly controls the light using a switch.

 Features

- Automatic lighting control
- Manual lighting control
- Motion detection
- Ambient-light detection
- Master ON/OFF switch
- Reset support
- Verilog testbench included

 Block Diagram

```text
             +-------------------+
             |   Master Switch   |
             +---------+---------+
                       |
                       v
+----------+     +-----------+     +----------+
| Motion   |---->|           |---->|          |
| Sensor   |     |   Smart   |     |  Light   |
+----------+     |   Home    |     |  Output  |
                 | Controller|     |          |
+----------+     |           |     +----------+
| Light    |---->|           |
| Sensor   |     +-----------+
+----------+

          Manual Switch
               |
               v
         Manual Control
