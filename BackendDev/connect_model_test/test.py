import csv
import os
import subprocess
import tempfile

from fastapi import HTTPException

# try:
#     # 构造完整的命令
#     command = "conda activate luka_bhi && python /home/pci/luka_bhi/nineth.py"
#
#     # 使用 subprocess 运行命令
#     result = subprocess.run(
#         ['bash', '-c', command],  # 在 bash shell 中执行命令
#         capture_output=True,      # 捕获标准输出和错误
#         text=True,                # 输出为字符串格式
#         check=True                # 如果命令失败则抛出异常
#     )
#     # 子进程执行完后会立即退出 返回到父进程
#     # 获取脚本输出
#     output = result.stdout # result 当中的标准输出 即通过标准输出 print 打印的值
#     print("Script output:", output)
# except subprocess.CalledProcessError as e:
#     print(f"Error running the script: {e.stderr}")
#     raise RuntimeError(f"Script execution failed: {e.stderr}")


trajectory_data = {'(1, 2)', '(3, 4)'}
pressure_data = [30, 40]
try:

    # 将 trajectory 写入临时 CSV 文件
    with tempfile.NamedTemporaryFile(mode='w+', newline='', delete=False, suffix='.csv') as temp_file:
        writer = csv.writer(temp_file)
        writer.writerow(["x", "y"])  # 假设 trajectory 中的坐标格式为 (x, y)

        # 遍历 trajectory 列表，将每个点写入 CSV 文件
        for point in trajectory_data:
            # 解析字符串 "(x, y)" 为两个数字 x 和 y
            x, y = eval(point)
            writer.writerow([x, y])

        trajectory_temp_file_path = temp_file.name

    with tempfile.NamedTemporaryFile(mode='w+', newline='', delete=False, suffix='.csv') as temp_file:
        writer = csv.writer(temp_file)
        writer.writerow(["Pressure"])  # 写入表头

        # 遍历 pressure 列表，将每个压力点写入 CSV 文件
        for pressure_point in pressure_data:
            writer.writerow([pressure_point])  # 写入每个压力点

        pressure_temp_file_path = temp_file.name
    ###############################################################################
    try:
        # 构造完整的命令
        VIRTUAL_ENV = "ad_model"
        MODEL = r"D:\FLUTTER_SPOTIFY\Spotify_clone\connect_model_test\model.py"

        # 指定 conda.sh 路径
        conda_bat_path = r"E:\Anaconda\Library\bin\conda.bat"
        command = [
            'call', conda_bat_path, 'activate', VIRTUAL_ENV,
            '&&', 'python', MODEL,
            '--pressure_file', pressure_temp_file_path,
            '--trajectory_file', trajectory_temp_file_path
        ]
        # 使用 subprocess 运行命令
        result = subprocess.run(
            command,
            shell=True,  # 在 shell 中执行命令
            capture_output=True,  # 捕获标准输出和错误
            text=True,  # 输出为字符串格式
            check=True  # 如果命令失败则抛出异常
        )
        # 子进程执行完后会立即退出 返回到父进程
        # 获取脚本输出
        output = result.stdout  # result 当中的标准输出 即通过标准输出 print 打印的值
        print(output)
    except subprocess.CalledProcessError as e:
        print(f"Error running the script: {e.stderr}")
        raise RuntimeError(f"Script execution failed: {e.stderr}")
    ##############################################################################
except Exception as e:
    raise HTTPException(status_code=500, detail=f"execute false: {str(e)}")

finally:
    # 清理临时文件
    if trajectory_temp_file_path and os.path.exists(trajectory_temp_file_path):
        os.remove(trajectory_temp_file_path)
    if pressure_temp_file_path and os.path.exists(pressure_temp_file_path):
        os.remove(pressure_temp_file_path)


