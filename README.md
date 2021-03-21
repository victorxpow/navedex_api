# Desafio - Navedex API
Projeto realizado com base no desafio proposto, foi feito usando Ruby on Rails e banco de dados postgres e Docker.

## Como iniciar o projeto
Para executar esse projeto você deve ter um computador, preferencialmente com Linux, com a linguagem de programação Ruby na versão 2.7.2, e também:

- postgres
- Nodejs
- Yarn

Dentro do diretório do projeto, você deve instalar as dependências definidas no arquivo Gemfile com o comando `ruby bin/setup` e 
`mv .env.sample .env` para adiconar as variaveis de ambiente.

Com todas dependências instaladas, execute rails server para consultar as rotas manualmente ou use o comando `rspec` para utilizar o suit de teste para o desafio.

Ou podemos utilizarr o Docker, bastando ter o Docker e docker-compose instalado.

## Rodando o projeto com docker

Dentro do diretório do projeto, você deve adiconar as variaveis de ambiente com o comando `mv .env.sample .env`, agora basta utilizar o comando `docker-compose up` para subir o projeto.

## Testando o projeto
### Postman

Após o projeto estiver rodando você pode usar esta [collection do postman](navedex_api.postman_collection.json) para testar as rotas ou fazer manualmente.

### Rspec

Utilize o comando `docker-compose run --service-ports rails bash` e tenha acesso ao bash do container e rode o comando `ruby bin/setup` para validar se todas as dependencias estão corretas e por ultimo o comando `rspec --format documentation` para rodar os testes elaborados para o desafio.

## Gem's Utilizadas

- Rspec - Para elaboração do Suit de testes
- Faker - Auxiliar com atributos dinamicos para os testes
- Factory Bot Rails - Para facilitar a criação de objetos para os testes
- Rubocop - Me auxilia a manter a boas praticas dentro da linguaguem
- Shoulda Matchers - facilitar as validações
- SimpleCov - garantir e acompanhar a cobertura de testes
- devise jwt - para autenticação e criação do token
- Active Model Serializer - facilitar o retorno dos atributos

### Etapas futuras

- Aumentar a cobertura de testes e o numero de cases.
- Refatorar o controller e testes - dry