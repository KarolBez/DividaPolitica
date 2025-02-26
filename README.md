
# Desafio BackEnd

Este projeto serve como propósito de treino das minhas skills na programação. Encontrei o repositório no Github e decidi fazer esse desafio para me desafiar 😁.

Este projeto é uma análise dos gastos dos políticos do nosso brasil, mais precisamente dos deputados. Os dados são de origem da câmara dos deputados, dados estes que são abertos para consulta pública.

Estou construindo este projeto como prática nas tecnologias mais abaixo, citadas no final deste README.

## Funcionalidades

Este projeto conta com algumas funcionalidades das quais tive algum contato prévio, mas outras que aprendi ao trabalhar nele. Dentre as principais, destaco as descritas abaixo:

- Importação de CSV com dados das despesas dos candidatos (o referido CSV pode ser encontrado neste [link](https://dadosabertos.camara.leg.br/swagger/api.html?tab=staticfile#staticfile));
- Selecionar o Estado para consulta dos dados, sendo possível realizar a consulta de um estado por vez.
- Listagem dos deputados de acordo com o total de gastos, do maior ao menor.
- Possibilidade de filtrar por nome, partido e até exercício da dívida. Ambos filtros podem ser aplicados simultaneamente.
- Detalhes de cada gasto dos deputados, destacando o maior gasto.
- Paginação dos dados, para evitar uma sobrecarga na tela, permitindo a navegação de 10 e 10 registros.
- Aplicação do tema dark/light (Em desenvolvimento).
- Desenvolvimento de uma tela de consulta de um modo geral, destacando os maiores gastos dos deputados com maiores gastos por estado (Em desenvolvimento)

## Rodando localmente

Para executar o sistema localmente, primeiramente faça o clone do repositório no github:

```bash
  git clone https://github.com/DevGuiRocha/DividaPolitica.git
```

Após o clone bem sucedido, entre no diretório do projeto

```bash
  cd DividaPolitica
```

Antes de mais nada, execute o comando para instalar todas as dependências e gems necessárias:

```bash
  bundle install
```

Após a instalação das gems necessárias, se necessário, edite o arquivo ```config/database.yml``` para alterar as configurações para seu ambiente local, assim como usuario e senha do PostgreSQL para conexões.

Com o ambiente local configurado, é necessário a execução dos seguintes comandos, para a criação das bases locais de desenvolvimento/testes e a criação das tabelas que serão usadas no sistema

```bash
  rails db:create
  rails db:migrate
```

Já existe um arquivo que contém os gastos do início do exercício de 2025, então se desejar já pode fazer a população do banco com esses dados. Para isso, basta executar o comando abaixo

```bash
  rails db:seed
```

Ps: Caso não opte por importar pelo seed, é possível a importação dos dados em CSV manualmente dentro do sistema.

Após as configurações, inicie o servidor

```bash
  rails s 
```

Com isso, o servidor será inicializado na porta padrão 3000. Acesse o sistema pela link

```bash
  localhost:3000
```

Caso deseje alterar a porta de inicialização do servidor, basta executar o comando abaixo

```bash
  rails s -p porta_de_sua_escolha
```

Ps: Apenas lembre a porta para quando for acessar o servidor web.

Caso não tenha feito a importação da seed inicial ou deseje importar novos registros, basta acessar o endereço abaixo, ou navegar pelo sistema até a página de Importar CSV

```bash
  /despesas/upload
```

Com isso, basta realizar o download do arquivo CSV disponibilizado no link informado anteriormente e importar no sistema. Após o processamento, será direcionado a tela inicial com os valores já atualizados.

## Rodando os testes

Foram desenvolvidos um total de 19 testes para a aplicação, dividos da seguinte maneira: 6 testes para o models de Deputado, 6 testes para o models de Despesa, 3 para o controller dos deputados e 4 para o controller das despesas. Para executar os testes individualmente, basta executar os comandos abaixo:

```bash
    bundle exec rspec spec/models/deputado_spec.rb
    bundle exec rspec spec/models/despesa_spec.rb
    bundle exec rspec spec/requests/deputados_spec.rb
    bundle exec rspec spec/requests/despesas_spec.rb
```

Pode ser verificado os testes de cada parte nos referidos arquivos. Os testes foram pensados em uma maneira simples e direta de testar a aplicação. Podem ser feitos testes mais específicos a depender da finalidade, mas atualmente já são o suficiente para testar a aplicação no seu estado atual.

Também é possível executar todos os testes de uma única vez, basta executar o comando abaixo:

```bash
    bundle exec rspec
```

## Stack utilizada

**Back-end:** 
- Ruby versão 3.0.0
- Rails versão 7.1.5

**Front-end:** 
- Html e CSS juntamente com bootstrap para estilização
- ERB para desenvolvimento da lógica aplicada no front

**Gems de destaque:** 
- Kaminari para melhor paginação dos dados
- Rspec para execução de testes na aplicação
- shoula-matchers para escrita de testes
- rails-controller-testing para testes dos controllers
- turbo-rails para melhora da responsividade
- stimulus-rails para melhora de interatividade
- bootstrap para criação da interface 

**Banco de dados:** 
- PostgreSQL versão 16 para armazenamento dos dados
- PgAdmin versão 4 para manipulação de dados

## Aprendizados

Neste projeto pude trabalhar com algumas gems bastantes úteis no desenvolvimento como a Kaminari para paginação e a RSpec para desenvolvimento de testes. Além disso, tive que desenvolver mais ainda meu lado FrontEnd, já que a parte visual é o que tras o 'charme' ao sistema, então muito de CSS/Bootstrap foi implementado para dar um toque a mais na aplicação.

Admito que o front se torna bem mais divertido quando se começa a entender as várias lógicas por trás, mas ainda sim é bastante divertido desenvolver a aplicação com um todo.