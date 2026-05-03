import React from "react";

function HomePage() {
  return (
    <div className="p-6 bg-red-900 w-full">
      {/* Header */}
      <h1 className="text-2xl font-bold mb-6">Restaurant Dashboard</h1>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
        <div className="bg-white p-5 rounded-2xl shadow">
          <h2 className="text-gray-500">Total Orders</h2>
          <p className="text-2xl font-bold mt-2">120</p>
        </div>

        <div className="bg-white p-5 rounded-2xl shadow">
          <h2 className="text-gray-500">Revenue</h2>
          <p className="text-2xl font-bold mt-2">₹45,000</p>
        </div>

        <div className="bg-white p-5 rounded-2xl shadow">
          <h2 className="text-gray-500">Customers</h2>
          <p className="text-2xl font-bold mt-2">80</p>
        </div>
      </div>

      {/* Main Section */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">

        {/* Recent Orders */}
        <div className="lg:col-span-2 bg-white p-5 rounded-2xl shadow">
          <h2 className="text-lg font-semibold mb-4">Recent Orders</h2>

          <table className="w-full text-left">
            <thead>
              <tr className="text-gray-500 border-b">
                <th className="py-2">Order ID</th>
                <th>Customer</th>
                <th>Amount</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              <tr className="border-b">
                <td className="py-2">#101</td>
                <td>Rahul</td>
                <td>₹500</td>
                <td className="text-green-600">Completed</td>
              </tr>

              <tr className="border-b">
                <td className="py-2">#102</td>
                <td>Priya</td>
                <td>₹750</td>
                <td className="text-yellow-600">Pending</td>
              </tr>

              <tr>
                <td className="py-2">#103</td>
                <td>Amit</td>
                <td>₹300</td>
                <td className="text-red-600">Cancelled</td>
              </tr>
            </tbody>
          </table>
        </div>

        {/* Quick Actions */}
        <div className="bg-white p-5 rounded-2xl shadow">
          <h2 className="text-lg font-semibold mb-4">Quick Actions</h2>

          <div className="flex flex-col gap-3">
            <button className="bg-blue-500 text-white py-2 rounded-lg hover:bg-blue-600">
              Add New Order
            </button>

            <button className="bg-green-500 text-white py-2 rounded-lg hover:bg-green-600">
              Add Menu Item
            </button>

            <button className="bg-purple-500 text-white py-2 rounded-lg hover:bg-purple-600">
              View Reports
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default HomePage;