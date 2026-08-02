# 📚 Catálogo de Livros

Aplicação web em **Ruby on Rails 8** para cadastrar livros e autores.
Interface estilizada com **Tailwind CSS** e banco de dados **SQLite**.

---

## Requisitos

- **Ruby 3.4.10** (versão definida em `.ruby-version`)
- **Git**
- **SQLite 3** (versão 3.8+)

> Não é necessário instalar Node.js/npm — a gem `tailwindcss-rails` já traz o
> próprio compilador do Tailwind.

---

## 🐧 Rodando no Linux

### 1. Instalar o Ruby

Recomendado usar um gerenciador de versões como o [mise](https://mise.jdx.dev/)
(ou `rbenv`/`asdf`). Com o **mise**:

```bash
# instala o mise (se ainda não tiver)
curl https://mise.run | sh

# dentro da pasta do projeto, instala a versão do .ruby-version
mise install
```

Confirme a versão:

```bash
ruby -v   # deve mostrar 3.4.10
```

### 2. Clonar o projeto e instalar as dependências

```bash
git clone <URL-DO-REPOSITORIO> catalogo-livros
cd catalogo-livros
bundle install
```

### 3. Preparar o banco de dados

```bash
bin/rails db:prepare
```

Isso cria o banco SQLite e carrega a estrutura das tabelas.

### 4. Rodar a aplicação

```bash
bin/dev
```

Acesse **http://localhost:3000** no navegador.

> O `bin/dev` sobe o servidor **e** o compilador do Tailwind ao mesmo tempo.
> Para parar, pressione `Ctrl + C`.

---

## 🪟 Rodando no Windows

### 1. Instalar o Ruby

Baixe o **Ruby + Devkit 3.4.x** no [RubyInstaller](https://rubyinstaller.org/downloads/)
e conclua a instalação (marque a opção de rodar o `ridk install` ao final,
escolhendo a opção padrão `MSYS2 and MINGW development toolchain`).

Confirme no **Prompt de Comando** ou **PowerShell**:

```powershell
ruby -v   # deve mostrar 3.4.x
```

Instale também o [Git para Windows](https://git-scm.com/download/win).

### 2. Clonar o projeto e instalar as dependências

```powershell
git clone <URL-DO-REPOSITORIO> catalogo-livros
cd catalogo-livros
bundle install
```

### 3. Preparar o banco de dados

No Windows, chame os comandos do projeto prefixando com `ruby`:

```powershell
ruby bin/rails db:prepare
```

### 4. Rodar a aplicação

Abra **dois terminais** na pasta do projeto:

**Terminal 1 — servidor web:**
```powershell
ruby bin/rails server
```

**Terminal 2 — compilador do Tailwind:**
```powershell
ruby bin/rails tailwindcss:watch
```

Acesse **http://localhost:3000** no navegador.

> 💡 Se você usa o **Git Bash**, pode rodar tudo de uma vez só com `bin/dev`,
> igual ao Linux (nesse caso, um único terminal já resolve).

---

## Estrutura rápida

| Recurso | Onde fica |
|---------|-----------|
| Telas (HTML) | `app/views/books` e `app/views/authors` |
| Estilos e botões | `app/assets/tailwind/application.css` |
| Rotas | `config/routes.rb` |
| Banco de dados | `storage/development.sqlite3` |

---

## Comandos úteis

```bash
bin/rails console      # abre o console interativo do Rails
bin/rails routes       # lista todas as rotas da aplicação
bin/rails test         # roda a suíte de testes
```

> No Windows, lembre-se de prefixar com `ruby` (ex.: `ruby bin/rails console`).

---

## Solução de problemas

- **`gem: not found` ou `ruby: not found` (Linux):** o gerenciador de versões
  não está ativo no terminal. Ative o mise (ex.: `eval "$(mise activate bash)"`)
  ou reabra o terminal. **Não use `sudo`** — o Ruby não é instalado como root.

- **`Permission denied - bin/rails` (Linux):** os scripts da pasta `bin/`
  perderam a permissão de execução. Rode uma vez: `chmod +x bin/*`.

- **`foreman: not found`:** rode `gem install foreman` e tente o `bin/dev`
  novamente.
