# Planner de Tarefas
## Projeto de avaliação da disciplina Laboratório de Programação de Dispositivos Móveis

Sistema Operacional utilizado para desenvolver e rodar o programa: Pop!_OS

Por alguma razão, no meu computador a tela vai direto para DashBoard(), porque por algum motivo, no Linux o valor de value em preferences.getInt("value") é setado para 1 e consequentemente mudando o status para LoginStatus.signIn.
Ao testar essa aplicação eu troquei a posição dos 2 na condicional, ficando:
  _loginStatus = (value == 1) ? LoginStatus.notSignIn : LoginStatus.signIn; 

Caso dê erro ao iniciar o projeto, leve em consideração essa mudança.

