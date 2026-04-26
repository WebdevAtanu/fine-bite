import { apiClient } from "./apiClient";

// GET (all or by id)
export const get = async <T>(url: string, params?: any): Promise<T> => {
  const res = await apiClient.get(url, { params });
  return res.data;
};

// POST (create)
export const post = async <T>(url: string, data: any): Promise<T> => {
  const res = await apiClient.post(url, data);
  return res.data;
};

// PUT (update)
export const put = async <T>(url: string, data: any): Promise<T> => {
  const res = await apiClient.put(url, data);
  return res.data;
};

// DELETE
export const remove = async <T>(url: string): Promise<T> => {
  const res = await apiClient.delete(url);
  return res.data;
};
