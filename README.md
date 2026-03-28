# TreinAI 🏋️‍♂️🤖

O **TreinAI** é um aplicativo de fitness inteligente que utiliza IA para gerar treinos personalizados baseados no perfil do usuário. Projetado com uma mentalidade **offline-first**, o app garante que o usuário tenha acesso ao seu plano de treino e registre seu progresso mesmo sem conexão com a internet.

## 🚀 Funcionalidades Principal
- **Onboarding Inteligente:** Coleta de objetivos, nível de experiência e limitações físicas.
- **Treinos Gerados por IA:** Integração com backend para criação de rotinas sob medida.
- **Modo Offline-first:** Banco de dados local (SQLite) como fonte única da verdade.
- **Acompanhamento de Execução:** Checkpoint de exercícios e histórico de progresso.

## 🛠️ Tech Stack
- **Framework:** [Flutter](https://flutter.dev)
- **Gerenciamento de Estado:** [Flutter BLoC](https://pub.dev/packages/flutter_bloc)
- **Banco de Dados Local:** [Drift](https://drift.simonbinder.eu/) (SQLite) ou [sqflite](https://pub.dev/packages/sqflite)
- **Injeção de Dependência:** [GetIt](https://pub.dev/packages/get_it)
- **Arquitetura:** Clean Architecture (Camadas: Data, Domain, Presentation)

## 🏗️ Arquitetura e Estrutura
O projeto segue os princípios da **Clean Architecture**, visando testabilidade e independência de frameworks.

```text
lib/
├── core/             # Código compartilhado, constantes e utilitários.
├── data/             # Implementação de repositórios, fontes de dados (Local/Remote) e Models.
├── domain/           # Entidades de negócio e Interfaces de Repositórios (Usecases).
├── presentation/     # UI (Widgets, Pages) e Gerenciamento de Estado (BLoCs).
└── main.dart         # Inicialização do App e Injeção de Dependências.
```

## 📋 Requisitos de Instalação
1. Certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (versão estável mais recente).
2. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/treinai.git
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Gere os arquivos de código (para Drift/JSON Serializer):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## 🗄️ Modelagem de Dados (Local)
O banco de dados local armazena:
- **Users & Profiles:** Dados do onboarding.
- **Workouts:** Cabeçalho do treino (nome, data, origem).
- **Exercises:** Catálogo detalhado de exercícios.
- **Workout_Exercises:** Relacionamento (séries, repetições, ordem).
- **Exercise_Logs:** Histórico de conclusão do usuário.

## 🔄 Fluxo de Sincronização
1. O usuário preenche o onboarding.
2. Os dados são enviados para a API.
3. A IA processa o treino e retorna um JSON estruturado.
4. O App persiste o treino no SQLite e marca como sincronizado.
5. Registros feitos offline são marcados com uma flag `is_synced: false` e sincronizados assim que a conexão for restaurada.

## 🛣️ Roadmap
- [ ] Setup inicial da estrutura de pastas e DI.
- [ ] Implementação da camada de persistência local (SQLite).
- [ ] Interface de Onboarding.
- [ ] Integração com a API de geração de treinos.
- [ ] Tela de execução de exercícios com Timer.
- [ ] Dashboards de evolução.
