# Desktop 4-DOF Robotic Arm
## Overview
This project is a custom_designed desktop 4-DOF robotic manipulator developed through the complete engineering process from kinematic analysis and mechanical design to transmission design, control, and prototype validation.

The manipulator is intended for tasks such as pick-and-place, planar trajectory tracing, and simple planar operations. The project is currently in the pre-prototype mechanical design stage.
## Design Objectives
- 4-DOF desktop robotic manipulator with approximately 0.5kg payload, and 320-350mm maximum reach
- Sufficient workspace for pick-and-place and planar operations with 3-5mm positioning repeatability
- Primarily 3D-printable primary structure, supplemented by laser-cut components
- Use of commonly avaliable and cost-efficient motors, bearings, and transmission components
- Future intergration of multi-axis motion control, including homing, FK/IK, and condinated MoveJ
## System Architecture
The manipulator consists of four primary revolute joints:
| Joint | Function | Transmission |
| --- | --- | --- |
| J1 | Base Rotation | Cycloidal Reducer |
| J2 | Shoulder | Cycloidal Reducer |
| J3 | Elbow | Timing Belt |
| J4 | Wrist | Timing Belt |
### Initial Kinematics Study
### Mechanical Design Constraints
### Cantilever Loading and Design Trade-offs
