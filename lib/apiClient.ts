import axios from "axios";

export const apiClient = axios.create({
  baseURL: `${process.env.NEXT_PUBLIC_API_URL}/api`,
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
    const errorData = error.response?.data || {
      message: "Something went wrong",
    };

    console.warn("API MESSAGE:", errorData.message);

    // return as resolved response instead of rejecting
    return Promise.resolve({
      data: errorData,
      status: error.response?.status || 500,
    });
  },
);
