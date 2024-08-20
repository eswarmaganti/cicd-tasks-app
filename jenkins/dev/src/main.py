import subprocess
import shlex
import os


home_dir = '/opt/SP/cicd-tasks-app'
playbook_path = f"{home_dir}/jenkins/dev/src/playbooks/dev-deploy.yaml"
inventory_path = f"{home_dir}/jenkins/dev/src/config/hosts"
play_command = shlex.split(f''' ansible-playbook -i {inventory_path} {playbook_path} ''')

res = subprocess.run(play_command)

if res.returncode == 0:
    print('Deployment is success')
else:
    print("Deployment failed!!!")
