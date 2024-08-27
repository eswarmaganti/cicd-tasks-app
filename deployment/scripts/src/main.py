import subprocess
import shlex
import os
import sys
from typing import List

class Deployment:

    def __init__(self,env) -> None:
        
        self.__env: str = env
        self.__project_root: str = os.getcwd()
        self.__inventory_path: str = f"{self.__project_root}/config/{env}/hosts"
        self.__playbook_path: str = f"{self.__project_root}/playbooks/{env}/app_deploy.yaml"
        self.__play_cmd: List[str] = shlex.split(f"ansible-playbook -i {self.__inventory_path} {self.__playbook_path}")

    def perform_deployment(self)->None:
        try:
            res = subprocess.run(self.__play_cmd)
            if res.returncode != 0:
                print(f"*** Error: Failed to run {self.__env} Deployment playbook successfully: {res.stderr}")
                raise Exception
            print(f"*** Success: {self.__env} Deployment is successfully completed ***")

        except Exception as e:
            print(f"*** Error: An Exception occured while {self.__env} deployment: {str(e)} ***")
            exit(0)

# main starts here
if __name__ == "__main__":
    try:
        env = sys.argv[0]
        obj = Deployment(env)
        obj.perform_deployment()

    except Exception as e:
        print(f"*** Error: Something went wrong while performing deployment: {str(e)} ***")
        exit(0)