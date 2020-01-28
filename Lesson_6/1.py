"""
1. Подсчитать, сколько было выделено памяти под переменные в ранее
разработанных программах в рамках первых трех уроков. Проанализировать
результат и определить программы с наиболее эффективным использованием памяти.
Примечание: Для анализа возьмите любые 1-3 ваших программы или несколько
вариантов кода для одной и той же задачи. Результаты анализа вставьте в виде
комментариев к коду. Также укажите в комментариях версию Python
и разрядность вашей ОС.
"""
from memory_profiler import profile
import copy
import random

def prime_or_not(number):
 for i in range(2, int(number**0.5)+1):
  if number % i == 0:
   return False
 return True

@profile
def what_prime(number=10000):
 a=[]
 i=1
 while len(a)<=number:
  if prime_or_not(i):
   a.append(i)
  i+=1
 return a[-1]




@profile
def odd_even_rec(n,odds=0,evens=0):
 if n==0:
  return
 if n%10%2==0:
  evens+=1
  odd_even_rec(n//10,odds,evens)
 else:
  odds+=1
  odd_even_rec(n//10,odds,evens)

@profile
def rec_sum(n=10,dig=1,sm=1):
 if n==1:
  print(f'Сумма ряда = {sm}\nЧисло ряда = {dig}')
  return n,dig,sm
 dig*=-0.5
 sm+=dig
 return rec_sum(n-1,dig,sm)

@profile
def fun():
 x=list(range(1000000))
 y = copy.deepcopy(x)
 del x
 y = None
 return y

@profile
def teor():
 n = 123456
 count = 0
 summ = 0
 while count<n:
  count+=1
  summ+=count
 return f'верно {summ} = {summ}' if summ==n*(n+1)/2 else f'неверно'

@profile
def digi():
 num = [i for i in range(2,10)]
 allnum = [i for i in range(2,10000)]
 res = {}
 for i in num:
  res[i]=0
  for k in allnum:
   if k%i==0:
    res[i]+=1
 for k,v in res.items():
  return f'Число {k}, кратных ему чисел {v}'

@profile
def rand_ar():
 random_array = [random.choice([i for i in range(10000)]) for g in range(30)]
 print(f'массив из случайных чисел:\n{random_array}')
 indexes_evens = [random_array.index(i) for i in random_array if i%2==0]
 print(f'Индексы чётных числе массива:\n{indexes_evens}')

@profile
def eratosphen(n=12345):
 a = [i for i in range(n+1)]
 a[1] = 0
 lst = []
 i = 2
 while i<=n:
  if a[i] !=0:
   lst.append(a[i])
   for j in range(i,n+1,i):
    a[j]=0
  i+=1
 return(lst)

if __name__ == '__main__':

 #odd_even_rec(123456789)
 rec_sum()
 #fun()
 #teor()
 #digi()
 #rand_ar()
 #what_prime()
 #eratosphen()


"""
Восновном память не раскодуется только при запуске самого  @profile и при выполнении 
32.4 MiB     19.2 MiB    x=list(range(1000000))...


64 битная Windors 10
Line #    Mem usage    Increment   Line Contents
================================================
    35     13.3 MiB     13.3 MiB   @profile
    36                             def odd_even_rec(n,odds=0,evens=0):
    37     13.3 MiB      0.0 MiB    if n==0:
    38     13.3 MiB      0.0 MiB     return
    39     13.3 MiB      0.0 MiB    if n%10%2==0:
    40     13.3 MiB      0.0 MiB     evens+=1
    41     13.3 MiB      0.0 MiB     odd_even_rec(n//10,odds,evens)
    42                              else:
    43     13.3 MiB      0.0 MiB     odds+=1
    44     13.3 MiB      0.0 MiB     odd_even_rec(n//10,odds,evens)



Line #    Mem usage    Increment   Line Contents
================================================
    46     13.2 MiB     13.2 MiB   @profile
    47                             def rec_sum(n=10,dig=1,sm=1):
    48     13.2 MiB      0.0 MiB    if n==1:
    49     13.2 MiB      0.0 MiB     print(f'Сумма ряда = {sm}\nЧисло ряда = {dig}')
    50     13.2 MiB      0.0 MiB     return n,dig,sm
    51     13.2 MiB      0.0 MiB    dig*=-0.5
    52     13.2 MiB      0.0 MiB    sm+=dig
    53     13.2 MiB      0.0 MiB    return rec_sum(n-1,dig,sm)




Line #    Mem usage    Increment   Line Contents
================================================
    55     13.3 MiB     13.3 MiB   @profile
    56                             def fun():
    57     32.4 MiB     19.2 MiB    x=list(range(1000000))
    58     37.2 MiB      4.7 MiB    y = copy.deepcopy(x)
    59     33.4 MiB      0.0 MiB    del x
    60     14.3 MiB      0.0 MiB    y = None
    61     14.3 MiB      0.0 MiB    return y



Process finished with exit code 0


"""