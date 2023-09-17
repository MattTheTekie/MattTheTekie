#Gitea repo cloner script. Clones specified username repos. - Made by MattTheTekie.
TOKEN={INSERT_TOKEN_HERE}
SERVER={$GITEA_URL/api/v1/users}
NAME={INSERT_USERNAME_HERE}
curl "$SERVER/$NAME/repos?access_token=$TOKEN" | grep -w clone_url | grep -o 'https://[^"]\+.git' | xargs -L1 git clone
