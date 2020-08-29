## API AGENDA EMAIL DESAFIO BACK-END

Este projeto tem como finalizade desenvolver uma api para uma aplicação de envio de emails ja existente, e integrala
##### Configuração/Ferramentas 

- Criar endpoints da API: https://github.com/agendakids/desafio-backend-rails/blob/master/README.md#api

## Documentação
----
* Banco de dados postgres 
* Docker and Postgres container
* Comando abaixo, configura uma imagem e cria um container com docker configurado:

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
* O projeto pode ser iniciado local com comando rails s.
* No database.yml do projeto configura host aponta para o docker por fim usuario root e senha root.
* Postman Canary utilizado para requisições REST.
* Caso não opite por esta configuração do banco de dados, basta altera o database.yml para forma que preferi.

**Agenda Mail/API**
----

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

**API**
----
## Operações sobre mensagem 
#### Lista mensagens
* URL de envio:
```shell
curl --location --request GET 'http://localhost:3000/api/v1/messages' \
--header 'Authorization: XXXX000000'
```
* Exemplo de retorno
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
* URL de envio
```shell
curl --location --request POST 'http://localhost:3000/api/v1/messages?message[receiver_email]=flaugabriel@gmail.com&message[title]=apiteste&message[content]=conteudo' \
--header 'Authorization: XXXX000000'
```
* parametros 
```code
message[receiver_email]: teste@teste.com
message[title]: apiteste
message[content]: conteudo
```
#### Mensagens enviadas 
* URL de envio

```shell
curl --location --request GET 'http://localhost:3000/api/v1/messages/sent' \
--header 'Authorization: XXXX000000'
```
* Exemplo de resposta
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
* URL de envio
```shell
curl --location --request GET 'http://localhost:3000/api/v1/messages/archived?permission=master' \
--header 'Authorization: XXXX000000
```
#### Visualiza Mensagem
* URL de envio
```shell
curl --location --request GET 'http://localhost:3000/api/v1/messages/1' \
--header 'Authorization: XXXX000000'
```
* Exemplo de retorno 
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
* URL de envio
```shell
curl --location --request PATCH 'http://localhost:3000/api/v1/messages/1/archive' \
--header 'Authorization: GABR132318'
```
* parametro
```code
id: 1
```
* Exemplo de retorno
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
* URL de envio
```shell
curl --location --request GET 'http://localhost:3000/api/v1/profile' \
--header 'Authorization: XXXX000000'
```
* Exemplo de retorno
```json
{
  "id": 2,
  "email": "flaugabriel@gmail.com",
  "name": "gabriel",
  "created_at": "2020-08-28T14:23:18.051-03:00",
  "updated_at": "2020-08-28T17:46:43.363-03:00",
  "permission": "normal",
  "token": "GABR132318"
}
```
#### Atualiza perfil
* URL de envio
```shell

```

