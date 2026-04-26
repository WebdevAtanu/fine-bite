import axios from "axios";

export const apiClient = axios.create({
  baseURL: process.env.API_URL || "http://localhost:3000/api",
  headers: {
    "Content-Type": "application/json",
  },
});

// request interceptor (auth token)
// apiClient.interceptors.request.use((config) => {
//   const token = localStorage.getItem("token");
//   if (token) {
//     config.headers.Authorization = `Bearer ${token}`;
//   }
//   return config;
// });

// response interceptor (global error handling)
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    console.error("API ERROR:", error.response?.data || error.message);

    return Promise.reject(
      error.response?.data || { message: "Something went wrong" },
    );
  },
);
