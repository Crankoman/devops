# Домашнее задание к занятию 10 «Jenkins»

## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.
2. Установить Jenkins при помощи playbook.

<-- Ответ

<details>  
<summary>подробнее</summary>
`ansible-playbook -i inventory/cicd/hosts.yml site.yml`

```commandline
PLAY [Preapre all hosts] ***************************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
The authenticity of host '84.201.140.138 (84.201.140.138)' can't be established.
ED25519 key fingerprint is SHA256:e0NPIud35yR2z6+nVG2isjdIrM3tg2bJoZOR9aTZPrI.
This key is not known by any other names
The authenticity of host '84.201.161.86 (84.201.161.86)' can't be established.
ED25519 key fingerprint is SHA256:CAi+Zjeid1YtzOvsScLXQw7NYHa74M2GdtR+M2pf4jg.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
ok: [jenkins-master-01]
yes
ok: [jenkins-agent-01]

TASK [Create group] ********************************************************************************************************************************************
changed: [jenkins-master-01]
changed: [jenkins-agent-01]

TASK [Create user] *********************************************************************************************************************************************
changed: [jenkins-agent-01]
changed: [jenkins-master-01]

TASK [Install JDK] *********************************************************************************************************************************************
changed: [jenkins-agent-01]
changed: [jenkins-master-01]

PLAY [Get Jenkins master installed] ****************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [jenkins-master-01]

TASK [Get repo Jenkins] ****************************************************************************************************************************************
changed: [jenkins-master-01]

TASK [Add Jenkins key] *****************************************************************************************************************************************
changed: [jenkins-master-01]

TASK [Install epel-release] ************************************************************************************************************************************
changed: [jenkins-master-01]

TASK [Install Jenkins and requirements] ************************************************************************************************************************
changed: [jenkins-master-01]

TASK [Ensure jenkins agents are present in known_hosts file] ***************************************************************************************************
# 84.201.161.86:22 SSH-2.0-OpenSSH_7.4
# 84.201.161.86:22 SSH-2.0-OpenSSH_7.4
# 84.201.161.86:22 SSH-2.0-OpenSSH_7.4
# 84.201.161.86:22 SSH-2.0-OpenSSH_7.4
# 84.201.161.86:22 SSH-2.0-OpenSSH_7.4
changed: [jenkins-master-01] => (item=jenkins-agent-01)
[WARNING]: Module remote_tmp /home/jenkins/.ansible/tmp did not exist and was created with a mode of 0700, this may cause issues when running as another user.
To avoid this, create the remote_tmp dir with the correct permissions manually

TASK [Start Jenkins] *******************************************************************************************************************************************
changed: [jenkins-master-01]

PLAY [Prepare jenkins agent] ***********************************************************************************************************************************

TASK [Gathering Facts] *****************************************************************************************************************************************
ok: [jenkins-agent-01]

TASK [Add master publickey into authorized_key] ****************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Create agent_dir] ****************************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Add docker repo] *****************************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Install some required] ***********************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Update pip] **********************************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Install Ansible] *****************************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Reinstall Selinux] ***************************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Add local to PATH] ***************************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Create docker group] *************************************************************************************************************************************
ok: [jenkins-agent-01]

TASK [Add jenkinsuser to dockergroup] **************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Restart docker] ******************************************************************************************************************************************
changed: [jenkins-agent-01]

TASK [Install agent.jar] ***************************************************************************************************************************************
changed: [jenkins-agent-01]

PLAY RECAP *****************************************************************************************************************************************************
jenkins-agent-01           : ok=17   changed=14   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
jenkins-master-01          : ok=11   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

</details>

---

3. Запустить и проверить работоспособность.

<-- Ответ

![2023-10-05_23-17-46.png](img%2F2023-10-05_23-17-46.png)

---

4. Сделать первоначальную настройку.

<-- Ответ

![2023-10-05_23-32-39.png](img%2F2023-10-05_23-32-39.png)

---

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

<-- Ответ

![screencapture-51-250-29-237-8080-job-freestyle-job-molecule-test-configure-2023-10-06-14_10_31.png](img%2Fscreencapture-51-250-29-237-8080-job-freestyle-job-molecule-test-configure-2023-10-06-14_10_31.png)
![2023-10-07_15-05-19.png](img%2F2023-10-07_15-05-19.png)

---

2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

<-- Ответ

![2023-10-07_15-33-38.png](img%2F2023-10-07_15-33-38.png)

```
pipeline {
    agent {
     label 'ansible'   
    }
    stages {
        stage('Build') {
            steps {
                git branch: 'main', credentialsId: 'c66431e7-973e-460e-9c36-9e166f7a4405', url: 'https://github.com/Crankoman/vector-role'

                sh "molecule test"
            }

        }
    }
    }
```

---

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.

<-- Ответ

https://github.com/Crankoman/devops/blob/main/ci/04/Jenkinsfile

---

4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

<-- Ответ

![2023-10-07_17-24-56.png](img%2F2023-10-07_17-24-56.png)

---

5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).



<-- Ответ

---

6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.

<-- Ответ

---

7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.

<-- Ответ

---

8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.


https://github.com/Crankoman/devops/blob/main/ci/04/Jenkinsfile


<-- Ответ

---

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, завершившиеся хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением и названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline так, чтобы он мог сначала запустить через Yandex Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Мы должны при нажатии кнопки получить готовую к использованию систему.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---