#/bin/bash
docker compose up -d
ansible-playbook -i inventory/prod.yml site.yml
# --vault-pass-file .pass_file
docker compose down
