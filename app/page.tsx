"use client";

import { useState } from "react";
import Image from "next/image";
import { motion } from "framer-motion";
import * as apiService from "../lib/apiService";
import { ApiResponseType } from "@/types/apiResponse";
import toast from "react-hot-toast";
import { useRouter } from "next/navigation";

export default function Home() {
  const [isLogin, setIsLogin] = useState(true);
  const [isLoading, setIsLoading] = useState(false);
  const [userInfo, setUserInfo] = useState({
    adminName: "",
    email: "",
    password: "",
  });
    const router = useRouter();

  const handleOperation = () => {
    if (isLogin) {
      handleLogin();
    }
    else {
      handleRegister();
    }
  }

  const handleRegister = async () => {
    setIsLoading(true);
    const response: ApiResponseType<object> = await apiService.post("/admin/auth/register", userInfo);
    if (response.success) {
      setIsLoading(false);
      toast.success(response.message);
      setUserInfo({ adminName: "", email: "", password: "" });
    }
    else {
      setIsLoading(false);
      toast.error(response.message);
    }
  };

  const handleLogin = async () => {
    setIsLoading(true);
    const response: ApiResponseType<object> = await apiService.post("/admin/auth/login", userInfo);
    if (response.success) {
      setIsLoading(false);
      toast.success(response.message);
      console.log(response.data);
      localStorage.setItem("token", (response.data as { token: string }).token);
      setUserInfo({ adminName: "", email: "", password: "" });
      router.push("/dashboard/home");
    }
    else {
      setIsLoading(false);
      toast.error(response.message);
    }
  };



  return (
    <div className="min-h-screen w-full flex">

      {/* LEFT PANEL} */}
      <div className="hidden lg:flex w-2/3 relative overflow-hidden">
        <Image
          src="/image/hero.jpg"
          alt="Logo"
          fill
          className="object-cover"
          priority
        />

      </div>

      {/* RIGHT PANEL - LOGIN/SIGNUP */}
      <div className="flex flex-1 items-center justify-center p-6">
        <motion.div
          layout
          transition={{ duration: 0.4, ease: "easeInOut" }}
          className="w-full max-w-md bg-white dark:bg-zinc-900 rounded-2xl shadow-lg border p-6"
        >
          <h2>LOGO</h2>

          <h2 className="text-2xl font-semibold text-center text-zinc-800 dark:text-white">
            {isLogin ? "Login Account" : "Create Account"}
          </h2>

          <div className="mt-8 space-y-4">

            <motion.div
              initial={false}
              animate={{
                height: isLogin ? 0 : "auto",
                opacity: isLogin ? 0 : 1,
              }}
              transition={{ duration: 0.35 }}
              className="overflow-hidden"
            >
              <input
                type="text"
                placeholder="Name"
                className="w-full px-4 py-3 rounded-lg border dark:border-zinc-700 dark:bg-zinc-800"
                value={userInfo.adminName}
                onChange={(e) => setUserInfo({ ...userInfo, adminName: e.target.value })}
              />
            </motion.div>

            <input
              type="email"
              placeholder="Email"
              className="w-full px-4 py-3 rounded-lg border dark:border-zinc-700 dark:bg-zinc-800"
              value={userInfo.email}
              onChange={(e) => setUserInfo({ ...userInfo, email: e.target.value })}
            />

            <input
              type="password"
              placeholder="Password"
              className="w-full px-4 py-3 rounded-lg border dark:border-zinc-700 dark:bg-zinc-800"
              value={userInfo.password}
              onChange={(e) => setUserInfo({ ...userInfo, password: e.target.value })}
            />

            <button className="w-full bg-black text-white dark:bg-white dark:text-black py-3 rounded-lg font-medium hover:opacity-90 transition disabled:opacity-50" onClick={() => handleOperation()} disabled={isLoading}>
              {isLogin ? "Login to Dashboard" : "Create Account"}
            </button>
          </div>

          <p className="text-center text-sm mt-6 text-zinc-500">
            {isLogin ? "New user?" : "Already registered?"}{" "}
            <button
              onClick={() => setIsLogin(!isLogin)}
              className="text-black dark:text-white font-medium underline"
            >
              {isLogin ? "Sign Up" : "Login"}
            </button>
          </p>

          <p className="text-xs text-center mt-6 text-zinc-400">
            Secure ERP access • Multi-branch support • Role based login
          </p>
        </motion.div>
      </div>
    </div>
  );
}