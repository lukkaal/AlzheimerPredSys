import argparse

# 创建解析器
parser = argparse.ArgumentParser()

# 定义参数
parser.add_argument('--pressure_file', type=str, help='Path to the pressure file')
parser.add_argument('--trajectory_file', type=str, help='Path to the trajectory file')

# 解析命令行参数
args = parser.parse_args()

# 获取传入的文件路径
pressure_file = args.pressure_file
trajectory_file = args.trajectory_file
Description = ('The patient exhibits mild cognitive impairment, '
               'characterized by slight memory lapses and difficulty recalling recent events. '
               'There is subtle disorientation, but overall functioning remains intact. '
               'Mild difficulties with daily tasks are noted, though the patient is still capable of '
               'managing most activities independently. '
               'Further monitoring and evaluation are recommended.')
# 使用这些文件路径进行推理
# print(f"Diagnosis result: {Description}")
print(Description)
# print(f"Pressure file: {pressure_file}")
# print(f"Trajectory file: {trajectory_file}")