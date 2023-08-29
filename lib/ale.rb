def fac(n)
    (1..n).inject(:*)
end

def a(n,m)
    fac(n+m) / (fac(n)*fac(m))
end

def b(n,m)
    n == 0 || m == 0 ? 1 : b(n-1,m) + b(n,m-1)
end 

puts a(3,3)
puts b(3,3)

# Cuantos caminos alternativos hay en una cuadricula de n * m?

def factorial(n)
  return 1 if n == 0
  (1..n).reduce(:*)
end

def calcular_caminos_alternativos(n, m)
  combinaciones = factorial(n + m - 2) / (factorial(n - 1) * factorial(m - 1))
  combinaciones
end

# Ingresa aquí las dimensiones de la cuadrícula (n y m)
n = 3
m = 3

caminos = calcular_caminos_alternativos(n, m)
puts "El número de caminos alternativos en una cuadrícula #{n}x#{m} es: #{caminos}"

def calcular_caminos_alternativos2(n, m)
  # Caso base: Cuando hay 0 filas o 0 columnas, la cantidad de caminos es 1
  return 1 if n == 0 || m == 0

  # Calcula la cantidad de caminos como la suma de avanzar una fila y avanzar una columna
  caminos_arriba = calcular_caminos_alternativos2(n - 1, m)
  caminos_izquierda = calcular_caminos_alternativos2(n, m - 1)

  # Retorna la suma de los caminos
  caminos_arriba + caminos_izquierda
end

# Ingresa aquí las dimensiones de la cuadrícula (n y m)
n = 3
m = 3

caminos = calcular_caminos_alternativos2(n, m)
puts "El número de caminos alternativos en una cuadrícula #{n}x#{m} es: #{caminos}"
