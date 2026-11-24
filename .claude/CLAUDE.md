## Precedencia (de mayor a menor)

1. Restricciones explícitas del usuario en la tarea ("no toques X").
2. `pnpm verify` en verde para terminar.
3. Extender el cambio solo a lo que el compilador o los tests señalan.

Si 1 y 2 entran en conflicto, detente y pregunta. Nunca modifiques
gates, tests existentes ni configuración para hacer pasar verify.
