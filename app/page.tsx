"use client";

import { useState } from "react";
import Image from "next/image";

export default function Home() {
  const [isLogin, setIsLogin] = useState(true);

  return (
    <div className="min-h-screen w-full flex bg-red-500">

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
        <div className="w-full max-w-md bg-white dark:bg-zinc-900 rounded-2xl shadow-xl p-6">

          <h2 className="">
            LOGO
          </h2>

          <h2 className="text-2xl font-semibold text-center text-zinc-800 dark:text-white">
            {isLogin ? "Login Account" : "Create Account"}
          </h2>

          <div className="mt-8 space-y-4">

            {!isLogin && (
              <input
                type="text"
                placeholder="Restaurant Name"
                className="w-full px-4 py-3 rounded-lg border dark:border-zinc-700 dark:bg-zinc-800"
              />
            )}

            <input
              type="email"
              placeholder="Email"
              className="w-full px-4 py-3 rounded-lg border dark:border-zinc-700 dark:bg-zinc-800"
            />

            <input
              type="password"
              placeholder="Password"
              className="w-full px-4 py-3 rounded-lg border dark:border-zinc-700 dark:bg-zinc-800"
            />

            <button className="w-full bg-black text-white dark:bg-white dark:text-black py-3 rounded-lg font-medium hover:opacity-90 transition">
              {isLogin ? "Login to Dashboard" : "Create Account"}
            </button>
          </div>

          {/* Toggle */}
          <p className="text-center text-sm mt-6 text-zinc-500">
            {isLogin ? "New user?" : "Already registered?"}{" "}
            <button
              onClick={() => setIsLogin(!isLogin)}
              className="text-black dark:text-white font-medium underline"
            >
              {isLogin ? "Sign Up" : "Login"}
            </button>
          </p>

          {/* Footer hint */}
          <p className="text-xs text-center mt-6 text-zinc-400">
            Secure ERP access • Multi-branch support • Role based login
          </p>

        </div>
      </div>
    </div>
  );
}