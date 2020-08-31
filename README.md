## API AGENDA EMAIL DESAFIO BACK-END

Este projeto tem como finalizade desenvolver uma api para uma aplicação de envio de emails ja existente, e integrala

##### Configuração/Ferramentas

- Criar endpoints da API: https://github.com/agendakids/desafio-backend-rails/blob/master/README.md#api

## Documentação

---

- Banco de dados postgres
- Docker and Postgres container
- Comando abaixo, configura uma imagem e cria um container com docker configurado:

```
  sudo docker run -d
  --name=postgres
  -v /etc/localtime:/etc/localtime:ro
  -e POSTGRES_USER=root
  -e POSTGRES_PASSWORD=root
  -v /storage/pgdata:/var/lib/postgresql/data
  -p 5432:5432
  --restart=always
  postgres

```

- O projeto pode ser iniciado local com comando rails s.
- No database.yml do projeto configura host aponta para o docker por fim usuario root e senha root.
- Postman Canary utilizado para requisições REST.
- Caso não opite por esta configuração do banco de dados, basta altera o database.yml para forma que preferi.

## **Agenda Mail/API**

Aplicação para troca de mensagens entre usuários.

Possui usuario master, que pode visualizar todas as mensangens, inclusive arquivadas.

Usuario Master:

email: master@email.com

password: 123456

#### Setup

```
bundle install
bundle exec rails db:setup
```

## **API**

## Operações sobre mensagem

- Token de usuario visualizado no perfil pelo web app

#### Lista mensagens

- URL de envio:

```shell
curl --location --request GET 'http://localhost:3000/api/v1/messages' \
--header 'Authorization: XXXX000000'
```

- Exemplo de retorno

```json
[
  {
    "id": 3,
    "title": "apiteste",
    "content": "conteudo",
    "from": 2,
    "to": 2,
    "visualized": null,
    "status": "unread",
    "archived": null,
    "response": null,
    "created_at": "2020-08-28T14:54:52.094-03:00",
    "updated_at": "2020-08-28T14:54:52.094-03:00"
  },
  {
    "id": 3,
    "title": "apiteste2",
    "content": "conteudo2",
    "from": 2,
    "to": 2,
    "visualized": null,
    "status": "unread",
    "archived": null,
    "response": null,
    "created_at": "2020-08-28T14:54:52.094-03:00",
    "updated_at": "2020-08-28T14:54:52.094-03:00"
  }
]
```

#### Criando mensagen

- URL de envio

```shell
curl --location --request POST 'http://localhost:3000/api/v1/messages?message[receiver_email]=flaugabriel@gmail.com&message[title]=apiteste&message[content]=conteudo' \
--header 'Authorization: XXXX000000'
```

- parametros

```code
message[receiver_email]: teste@teste.com
message[title]: apiteste
message[content]: conteudo
```

- Exemplo de resposta

```json
{
  "messager": "Mensagem enviada com sucesso."
}
```

#### Mensagens enviadas

- URL de envio

```shell
curl --location --request GET 'http://localhost:3000/api/v1/messages/sent' \
--header 'Authorization: XXXX000000'
```

- Exemplo de resposta

```json
[
  {
    "id": 3,
    "title": "apiteste",
    "content": "conteudo top",
    "from": 2,
    "to": 2,
    "visualized": null,
    "status": "unread",
    "archived": null,
    "response": null,
    "created_at": "2020-08-28T14:54:52.094-03:00",
    "updated_at": "2020-08-28T14:54:52.094-03:00"
  },
  {
    "id": 2,
    "title": "apiteste",
    "content": "conteudo top",
    "from": 2,
    "to": 1,
    "visualized": null,
    "status": "unread",
    "archived": null,
    "response": null,
    "created_at": "2020-08-28T14:52:09.909-03:00",
    "updated_at": "2020-08-28T14:52:09.909-03:00"
  }
]
```

#### Mensagens Arquivadas

- URL de envio

```shell
curl --location --request GET 'http://localhost:3000/api/v1/messages/archived?permission=master' \
--header 'Authorization: XXXX000000
```

- Exemplo de retorno

```json
[
  {
    "id": 2,
    "title": "apiteste",
    "content": "conteudo top",
    "from": 2,
    "to": 1,
    "visualized": "2020-08-29T21:32:19.219-03:00",
    "status": "archived",
    "archived": "2020-08-29T21:32:25.630-03:00",
    "response": null,
    "created_at": "2020-08-28T14:52:09.909-03:00",
    "updated_at": "2020-08-29T21:32:25.629-03:00"
  },
  {
    "id": 1,
    "title": "apiteste",
    "content": "conteudo top",
    "from": 2,
    "to": 1,
    "visualized": null,
    "status": "archived",
    "archived": "2020-08-28T15:30:09.273-03:00",
    "response": null,
    "created_at": "2020-08-28T14:50:44.521-03:00",
    "updated_at": "2020-08-28T15:30:09.272-03:00"
  }
]
```

#### Visualiza Mensagem

- URL de envio

```shell
curl --location --request GET 'http://localhost:3000/api/v1/messages/1' \
--header 'Authorization: XXXX000000'
```

- Exemplo de retorno

```json
{
  "id": 1,
  "title": "apiteste",
  "content": "conteudo top",
  "from": 2,
  "to": 1,
  "visualized": null,
  "status": "archived",
  "archived": "2020-08-28T15:30:09.273-03:00",
  "response": null,
  "created_at": "2020-08-28T14:50:44.521-03:00",
  "updated_at": "2020-08-28T15:30:09.272-03:00"
}
```

#### Arquiva mensagem

- URL de envio

```shell
curl --location --request PATCH 'http://localhost:3000/api/v1/messages/1/archive' \
--header 'Authorization: XXXX000000'
```

- parametro

```code
id: 1
```

- Exemplo de retorno

```json
{
  "id": 1,
  "status": "archived",
  "title": "apiteste",
  "content": "conteudo top",
  "from": 2,
  "to": 1,
  "visualized": null,
  "archived": "2020-08-28T15:30:09.273-03:00",
  "response": null,
  "created_at": "2020-08-28T14:50:44.521-03:00",
  "updated_at": "2020-08-28T15:30:09.272-03:00"
}
```

#### Visualiza perfil

- URL de envio

```shell
curl --location --request GET 'http://localhost:3000/api/v1/profile' \
--header 'Authorization: XXXX000000'
```

- Exemplo de retorno

```json
{
  "id": 2,
  "email": "teste1@gmail.com",
  "name": "teste1",
  "created_at": "2020-08-28T14:23:18.051-03:00",
  "updated_at": "2020-08-28T17:46:43.363-03:00",
  "permission": "normal",
  "token": "XXXX000000"
}
```

#### Consulta usúarios

- URL de envio

```shell
curl --location --request GET 'http://localhost:3000/api/v1/users?permission=master' \
--header 'Authorization: XXXX000000
```

- Exemplo de resposta

```json
[
  {
    "id": 2,
    "email": "teste1@gmail.com",
    "name": "teste1",
    "created_at": "2020-08-28T14:23:18.051-03:00",
    "updated_at": "2020-08-28T17:46:43.363-03:00",
    "permission": "normal",
    "token": "TEST32318"
  },
  {
    "id": 3,
    "email": "teste2@gmail.com",
    "name": "teste2",
    "created_at": "2020-08-28T14:23:18.051-03:00",
    "updated_at": "2020-08-28T17:46:43.363-03:00",
    "permission": "normal",
    "token": "TEST132322"
  }
]
```

#### Mensagem de usuarios

- URL de envio

```shell
curl --location --request GET 'http://localhost:3000/api/v1/users/2/messages?permission=master' \
--header 'Authorization: XXXX000000'
```

- Exemplo de resposta

```json
{
  "user": {
    "id": 2,
    "email": "teste1@gmail.com",
    "name": "teste1",
    "created_at": "2020-08-28T14:23:18.051-03:00",
    "updated_at": "2020-08-28T17:46:43.363-03:00",
    "permission": "normal",
    "token": "TEST132318"
  },
  "sent": [
    {
      "id": 3,
      "title": "apiteste",
      "content": "conteudo",
      "from": 2,
      "to": 2,
      "visualized": null,
      "status": "unread",
      "archived": null,
      "response": null,
      "created_at": "2020-08-28T14:54:52.094-03:00",
      "updated_at": "2020-08-28T14:54:52.094-03:00"
    }
  ],
  "received": [
    {
      "id": 4,
      "title": "apiteste",
      "content": "conteudo",
      "from": 1,
      "to": 2,
      "visualized": null,
      "status": "unread",
      "archived": null,
      "response": null,
      "created_at": "2020-08-29T21:17:03.091-03:00",
      "updated_at": "2020-08-29T21:17:03.091-03:00"
    },
    {
      "id": 3,
      "title": "apiteste",
      "content": "conteudo",
      "from": 2,
      "to": 2,
      "visualized": null,
      "status": "unread",
      "archived": null,
      "response": null,
      "created_at": "2020-08-28T14:54:52.094-03:00",
      "updated_at": "2020-08-28T14:54:52.094-03:00"
    }
  ]
}
```

#### Atualiza perfil

- URL de envio

```shell
curl --location --request PATCH 'http://localhost:3000/api/v1/users/1?user[name]=TESTE' \
--header 'Authorization: XXXX000000'
```

- Exemplo de resposta

```json
{
  "messager": "Perfil editado com sucesso.",
  "profile": {
    "id": 1,
    "name": "TESTE",
    "email": "master@email.com",
    "created_at": "2020-08-28T13:43:33.926-03:00",
    "updated_at": "2020-08-29T22:05:28.622-03:00",
    "permission": "master",
    "token": "ADMI124333"
  }
}
```