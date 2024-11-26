# Имя файла с Promela моделью
MODEL=model_1_3.pml

# Имя скомпилированного исполняемого файла
PAN=pan

# Цель по умолчанию: компиляция модели
all: $(PAN)

# Генерация pan.c с использованием SPIN
pan.c: $(MODEL)
	./spin651_mac64 -a $(MODEL)

# Компиляция pan.c
$(PAN): pan.c
	gcc -o $(PAN) pan.c

# Удаление временных файлов
clean:
	rm -f $(PAN) pan.* *.trail
	rm -f *.tmp
	rm -f *.trail

# Запуск проверки свойства p1
verify-p1: clean $(PAN)
	@echo "Запуск проверки свойства p1 (LTL #1)"
	@./$(PAN) -N p1 | tee pan_output.log
	@grep "State-vector" pan_output.log || echo "State-vector information not found."

# Запуск проверки свойства np1
verify-np1: clean $(PAN)
	@echo "Запуск проверки свойства np1 (LTL #2)"
	@./$(PAN) -N np1 | tee pan_output.log
	@grep "State-vector" pan_output.log || echo "State-vector information not found."
