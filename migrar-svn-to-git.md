## Migrar SVN para GIT

1. Faça checkout do seu projeto SVN.
2. Entre no diretório local e busque os usuários através do comando `svn log --xml | grep "<author>" | sort -u | perl -pe 's/.*>(.*?)<.*/$1 = /' | tee users.txt`
3. Corrija o arquivo _user.txt_ com o nome e email do usuário do GIT.
4. Mova este arquivo para o diretorio onde fará a migração.
5. Para converter o repositório em git utilize o comando `git svn clone --stdlayout --no-metadata --authors-file=users.txt svn://hostname/path dest_dir-tmp` ou `git svn clone --no-metadata --authors-file=users.txt svn://hostname/path dest_dir-tmp` conforme o caso.
6. Verifique se os arquivos foram baixados e se o `git log`esta correto.
7. Linque o repositório local git com o remoto `git remote add origin git@github.com:user/project-name.git`
8. Faça os ajustes com os comandos:
```
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
```
e pode fazer o push:
```
git push
```
