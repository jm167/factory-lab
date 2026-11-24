export type OrderStatus = "draft" | "paid" | "shipped" | "cancelled";

export function label(status: OrderStatus): string {
  switch (status) {
    case "draft":
      return "Borrador";
    case "paid":
      return "Pagado";
    case "shipped":
      return "Enviado";
    case "cancelled":
      return "Cancelado";
  }
}
