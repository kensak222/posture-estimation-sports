# Makefile for Flutter project using fvm

# Define fvm flutter command prefix
FVM_FLUTTER = fvm flutter

# Define code_uml command
CODE_UML = code_uml

# Default target
.DEFAULT_GOAL := help

# Declare phony targets (those that are not actual files)
.PHONY: help clean pub-get run test build format analyze doctor create-release generate-uml

# Help command to show available targets
help:
	@echo "Flutter makefile commands:"
	@echo "  make clean             - Clean project"
	@echo "  make pub-get           - Get dependencies"
	@echo "  make run               - Run the app"
	@echo "  make test              - Run tests"
	@echo "  make build             - Build the app"
	@echo "  make format            - Format the code"
	@echo "  make analyze           - Analyze the code"
	@echo "  make doctor            - Run flutter doctor"
	@echo "  make create-release    - Create release build"
	@echo "  make generate-uml      - Generate class UML diagram"

# Clean the project (flutter clean)
clean:
	$(FVM_FLUTTER) clean

# Get dependencies (flutter pub get)
pub-get:
	$(FVM_FLUTTER) pub get

# Run the app (flutter run)
run:
	$(FVM_FLUTTER) run

# Run tests (flutter test)
test:
	$(FVM_FLUTTER) test

# Build the app (flutter build)
build:
	$(FVM_FLUTTER) build

# Format the code (flutter format)
format:
	$(FVM_FLUTTER) format .

# Analyze the code (flutter analyze)
analyze:
	$(FVM_FLUTTER) analyze

# Run flutter doctor (flutter doctor)
doctor:
	$(FVM_FLUTTER) doctor

# Create a release build (flutter build apk / ios)
create-release:
	$(FVM_FLUTTER) build apk --release # For Android
	# $(FVM_FLUTTER) build ios --release # For iOS (uncomment if necessary)

# Add a library to the flutter project (flutter pub add [lib])
add-lib:
	$(FVM_FLUTTER) pub add $(lib)

# Activate a Dart global library (dart pub global activate [lib])
activate-lib:
	dart pub global activate $(lib)

# Generate UML class diagram (code_uml)
# クラスを自動生成する場合は、https://github.com/chashkovdaniil/graph_analyzer/ を参考に、
# <your_path_to_dir_input> と <your_path_to_dir_output> を各自にあったものに変更してください
generate-uml:
	$(CODE_UML) --from="F:\self_training\flutter\posture-estimation-sports\lib" --to="F:\self_training\flutter\posture-estimation-sports" --uml=plantuml
