## Escalamiento

Si una restricción explícita del usuario choca con `pnpm verify`:

1. No hagas el cambio que viola la restricción.
2. Si tienes la herramienta de preguntas interactivas, úsala con opciones concretas.
3. Si no la tienes, explica el conflicto y termina tu mensaje con
   `[NEEDS-USER]` en una línea aparte, al final.

Usa `[NEEDS-USER]` solo para conflictos entre una restricción del usuario
y los gates. Nunca para evitar un error que puedes corregir dentro del alcance.
