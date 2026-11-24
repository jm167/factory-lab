## Precedencia

1. `pnpm verify` en verde es obligatorio para terminar cualquier tarea.
2. Si el alcance pedido rompe verify, extiende el cambio solo a lo que
   el compilador o los tests señalan como consecuencia directa.
3. Si cumplir verify exige tocar algo fuera de ese radio, o algo
   explícitamente prohibido, detente y pregunta. Nunca modifiques
   gates, tests existentes ni configuración para hacer pasar verify.
