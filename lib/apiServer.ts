// lib/apiServer.ts
export async function serverGet<T>(url: string): Promise<T> {
  const BASE_URL = process.env.API_URL?.startsWith("http")
    ? process.env.API_URL
    : "http://localhost:3000";

  const res = await fetch(`${BASE_URL}${url}`, {
    next: { revalidate: 60 },
  });

  if (!res.ok) {
    throw new Error("Failed to fetch");
  }

  const data = await res.json();
  return data;
}
