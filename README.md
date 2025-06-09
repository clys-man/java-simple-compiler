# Compilador de Linguagem de Programação em Português

Um compilador simples para uma linguagem de programação com sintaxe em português brasileiro, desenvolvido com JFlex (lexer) e CUP (parser).

## Características da Linguagem

- **Palavras-chave em português**: `se`, `senao`, `enquanto`, `para`, `funcao`, etc.
- **Tipos de dados**: `inteiro`, `real`, `logico`, `cadeia`, `vazio`
- **Verificação de tipos estática**
- **Suporte a funções e escopo de variáveis**
- **Estruturas de controle tradicionais**

## Tipos de Dados

- `inteiro` - números inteiros
- `real` - números decimais
- `logico` - valores booleanos (`VERDADEIRO`, `FALSO`)
- `cadeia` - strings de texto
- `vazio` - tipo void para funções

## Exemplos de Código

### Variáveis e Operações Básicas

```
inteiro x = 10;
real y = 3.14;
logico ativo = VERDADEIRO;
cadeia nome = "João";

x = x + 5;
y = y * 2.0;
```

### Estruturas Condicionais

```
se (x > 5) {
    escreva("X é maior que 5");
} senao {
    escreva("X é menor ou igual a 5");
}
```

### Laços de Repetição

```
// Laço while
inteiro contador = 0;
enquanto (contador < 10) {
    contador = contador + 1;
}

// Laço for
para (inteiro i = 0; i < 5; i += 1;) {
    // faz algo
}
```

### Funções

```
// Função sem parâmetros e sem retorno
funcao fazAlgo() {
    // faz algo
}

// Função com parâmetros e retorno
funcao inteiro somar(inteiro a, inteiro b) {
    retorne a + b;
}

// Chamada de funções
inteiro resultado = somar(10, 20);

se (resultado > 5) {
    fazAlgo();
} senao se (resultado > 10) {
    fazAlgo();
} senao {
    fazAlgo();
}
```

### Operadores

#### Aritméticos
- `+` (adição)
- `-` (subtração)
- `*` (multiplicação)
- `/` (divisão)
- `%` (módulo)

#### Relacionais
- `==` (igual)
- `!=` (diferente)
- `<` (menor)
- `<=` (menor ou igual)
- `>` (maior)
- `>=` (maior ou igual)

#### Lógicos
- `&&` (e lógico)
- `||` (ou lógico)
- `!` (negação)

#### Atribuição
- `=` (atribuição simples)
- `+=`, `-=`, `*=`, `/=` (atribuição composta)

## Estrutura do Projeto

- `scanner.flex` - Analisador léxico (JFlex)
- `parser.cup` - Analisador sintático (CUP)
- Verificação semântica integrada
- Controle de escopo de variáveis e funções
- Sistema de tipos com verificação estática

## Características Técnicas

- **Lexer**: Reconhece tokens, identifica palavras-chave, literais e operadores
- **Parser**: Constrói árvore sintática e realiza análise semântica
- **Verificação de Tipos**: Garante compatibilidade entre operações
- **Gerenciamento de Escopo**: Controla visibilidade de variáveis e funções
- **Tratamento de Erros**: Mensagens de erro detalhadas em português

## Como Compilar e Executar

### 1. Preparar o Ambiente

Certifique-se de ter Java 24 e Maven instalados.

### 2. Gerar as Classes

```bash
mvn clean compile
```

Este comando irá:
- Gerar automaticamente as classes `scanner` e `parser`
- Compilar todo o projeto

### 3. Criar o Arquivo de Entrada

Crie um arquivo `src/main/resources/input.txt` com código na linguagem:

```
inteiro x = 10;
inteiro y = 20;
inteiro soma = x + y;

se (soma > 25) {
    escreva("Soma é maior que 25");
}
```

### 4. Executar o Compilador

```bash
mvn exec:java -Dexec.mainClass="com.clysman.compiler.Compiler"
```

Ou compile e execute diretamente:

```bash
mvn clean compile
java -cp target/classes com.clysman.compiler.Compiler
```

## Comandos Úteis

```bash
# Limpar e compilar
mvn clean compile

# Executar
mvn exec:java -Dexec.mainClass="com.clysman.compiler.Compiler"

# Gerar apenas as classes do lexer/parser
mvn generate-sources

# Empacotar em JAR
mvn package
```

O compilador realizará análise léxica, sintática e semântica automaticamente, reportando erros detalhados quando encontrados.