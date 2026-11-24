import { describe, it, expect } from "vitest";
import { label } from "./order-status.js";

describe("label", () => {
  it("traduce paid", () => {
    expect(label("paid")).toBe("Pagado");
  });
  it("traduce draft", () => {
    expect(label("draft")).toBe("Borrador");
  });
  it("traduce shipped", () => {
    expect(label("shipped")).toBe("Enviado");
  });
  it("traduce cancelled", () => {
    expect(label("cancelled")).toBe("Cancelado");
  });
});
