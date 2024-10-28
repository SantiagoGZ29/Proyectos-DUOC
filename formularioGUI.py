import tkinter as tk
from tkinter import messagebox

def mostrar_datos():
    nombre = entry_nombre.get()
    correo = entry_correo.get()
    telefono = entry_telefono.get()
    edad = entry_edad.get()
    sexo = entry_sexo.get()
    
    formulario = f"Nombre: {nombre}\nCorreo: {correo}\nTeléfono: {telefono}\nEdad: {edad}\nSexo: {sexo}"
    messagebox.showinfo("Datos Ingresados", formulario)

# Crear la ventana principal
root = tk.Tk()
root.title("Formulario de Registro")

# Crear y colocar las etiquetas y campos de entrada
tk.Label(root, text="Nombre:").grid(row=0, column=0, padx=10, pady=5)
entry_nombre = tk.Entry(root)
entry_nombre.grid(row=0, column=1, padx=10, pady=5)

tk.Label(root, text="Correo:").grid(row=1, column=0, padx=10, pady=5)
entry_correo = tk.Entry(root)
entry_correo.grid(row=1, column=1, padx=10, pady=5)

tk.Label(root, text="Teléfono:").grid(row=2, column=0, padx=10, pady=5)
entry_telefono = tk.Entry(root)
entry_telefono.grid(row=2, column=1, padx=10, pady=5)

tk.Label(root, text="Edad:").grid(row=3, column=0, padx=10, pady=5)
entry_edad = tk.Entry(root)
entry_edad.grid(row=3, column=1, padx=10, pady=5)

tk.Label(root, text="Sexo:").grid(row=4, column=0, padx=10, pady=5)
entry_sexo = tk.Entry(root)
entry_sexo.grid(row=4, column=1, padx=10, pady=5)

# Crear y colocar el botón de enviar
tk.Button(root, text="Guardar", command=mostrar_datos).grid(row=5, column=0, columnspan=2, pady=10)

# Iniciar el bucle principal de la aplicación
root.mainloop()
