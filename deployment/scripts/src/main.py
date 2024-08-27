import subprocess
import shlex
import os
import sys
from typing import List

class Deployment:

    def __init__(self,env:str, action:str) -> None:
        
        self.__env: str = env
        self.__action: str = action
        self.__home_dir: str = os.getcwd()
        self.__project_root: str = f"{self.__home_dir}/deployment/scripts/src"
        self.__inventory_path: str = f"{self.__project_root}/config/{env}/hosts"
        

    def __perform_deployment(self)->None:
        try:
            playbook_path: str = f"{self.__project_root}/playbooks/{env}/app_deploy.yaml"
            play_cmd: List[str] = shlex.split(f"ansible-playbook -i {self.__inventory_path} {playbook_path} --extra-vars 'proj_working_dir={self.__home_dir}' ")
            res = subprocess.run(play_cmd)
            if res.returncode != 0:
                print(f"*** Error: Failed to run {self.__env} Deployment playbook successfully: {res.stderr}")
                raise Exception(res.stderr)
            
            print(f"*** Success: {self.__env} Deployment is successfully completed ***")

        except Exception as e:
            print(f"*** Error: An Exception occured while {self.__env} deployment: {str(e)} ***")
            exit(1)

    def __perform_rollback_deployment(self)->None:
        try:
            playbook_path: str = f"{self.__project_root}/playbooks/{env}/app_rollback.yaml"
            play_cmd: List[str] = shlex.split(f"ansible-playbook -i {self.__inventory_path} {playbook_path} --extra-vars 'proj_working_dir={self.__home_dir}' ")
            res = subprocess.run(play_cmd)

            if res.returncode != 0:
                print(f"*** Error: Failed to run {self.__env} Rollback playbook, runtime error occured: {res.stderr}")
                raise Exception(res.stderr)
            
            print(f"*** Success: {self.__env} Rollback is successfully completed ***")
        except Exception as e:
            print(f"*** Error: Failed to run the Rollback stage: {str(e)} ***")


    def trigger_action(self)-> None:
        if self.__action == "deploy":
            self.__perform_deployment()
        elif self.__action == "rollback":
            self.__perform_rollback_deployment()
        else:
            raise Exception(f"Invalid action-{self.__action} passed as input")


# main starts here
if __name__ == "__main__":
    try:
        env = sys.argv[1]
        action = sys.argv[2]
        obj = Deployment(env,action)
        obj.trigger_action()

    except Exception as e:
        print(f"*** Error: Something went wrong while performing deployment: {str(e)} ***")
        exit(1)