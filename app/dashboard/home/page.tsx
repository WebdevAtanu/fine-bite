import React from "react";
import Chart from "@/components/chart";

const stats = [
  { label: "Total orders", value: "120", trend: "↑ 8% today" },
  { label: "Revenue", value: "₹45k", trend: "↑ 12% today" },
  { label: "Customers", value: "80", trend: "↑ 5% today" },
  { label: "Menus", value: "80", trend: "↑ 5% today" },
];

const actions = [
  "New order",
  "Add menu item",
  "View reports",
  "View orders",
  "View menus",
  "View settings",
  "View analytics",
];

export default function HomePage() {
  const datetime = new Date().toLocaleString();
  return (
    <div className="min-h-screen bg-stone-100 p-5 w-full">
      {/* Header */}
      <div className="mb-6 flex items-center justify-between">
        <div className="flex flex-col items-start gap-2">
          <span className="text-sm font-medium">Dashboard</span>
          <span className="text-sm font-medium">{datetime}</span>
        </div>

        <div className="flex gap-2">
          <div className="">🔔</div>
          <div className="">
            <input type="text" name="" id="" className="border-2 border-black" />
          </div>
        </div>
      </div>

      {/* Stats */}
      <div className="mb-4 grid grid-cols-2 gap-4 md:grid-cols-4">
        {stats.map((s) => (
          <div
            key={s.label}
            className="rounded-xl border border-neutral-200 bg-white p-4"
          >
            <p className="mb-1 text-xs text-gray-500">{s.label}</p>

            <p className="font-mono text-2xl font-semibold tracking-tight">
              {s.value}
            </p>

            <p className="mt-1.5 text-[11px] font-medium text-green-700">
              {s.trend}
            </p>
          </div>
        ))}
      </div>

      {/* Main Grid */}
      <div className="grid grid-cols-1 gap-4 lg:grid-cols-3">
        <div className="col-span-2 rounded-xl border border-neutral-200 bg-white p-4">
          <div className="flex justify-between">
            <div className="flex flex-col items-start">
              <h3>Order Summary</h3>
              <p>Summary of orders</p>
            </div>
            <div>
              dropdown
            </div>
          </div>
          <hr />
          {/* Charts */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Chart />
            <div>
              <h3>15000</h3>
              <p>from 1000</p>
            </div>
          </div>
        </div>

        {/* Actions */}
        <div className="rounded-xl border border-neutral-200 bg-white p-4">
          <p className="mb-4 text-sm font-medium">Quick actions</p>
          <div className="space-y-2">
            {actions.map((a) => (
              <button
                key={a}
                className="flex w-full items-center justify-between rounded-lg border border-neutral-200 bg-white px-3 py-3 text-left text-sm transition hover:bg-neutral-50"
              >
                <span>{a}</span>

                <span className="text-gray-400">›</span>
              </button>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}