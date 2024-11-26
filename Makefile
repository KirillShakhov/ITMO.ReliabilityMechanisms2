# Имя файла с Promela моделью
MODEL=model_1_1.pml

# Имя скомпилированного исполняемого файла
PAN=pan

# Цель по умолчанию: компиляция модели
all: $(PAN)

# Генерация pan.c с использованием SPIN
pan.c: $(MODEL)
	spin -a $(MODEL)

# Компиляция pan.c
$(PAN): pan.c
	gcc -o $(PAN) pan.c

# Запуск проверки свойства p1
verify-p1: $(PAN)
	@echo "Запуск проверки свойства p1 (LTL #1)"
	./$(PAN) -N p1

# Запуск проверки свойства np1
verify-np1: $(PAN)
	@echo "Запуск проверки свойства np1 (LTL #2)"
	./$(PAN) -N np1

# Объединенная цель для удобного вызова
verify: verify-p1 verify-np1

# Удаление временных файлов
clean:
	rm -f $(PAN) pan.* *.trail
	rm -f _spin_nvr.tmp