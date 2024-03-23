from flask import Flask,jsonify,render_template,request,redirect,url_for,session
from flask_mysqldb import MySQL

app = Flask(__name__,static_url_path="/static")
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'shriyash123'
app.config['MYSQL_DB'] = 'food_delivery_system'
mysql = MySQL(app)

@app.route('/')
def index():
    cur = mysql.connection.cursor()

    # Execute first query to fetch data from the 'users' table
    cur.execute('SELECT * FROM customers')
    users_data = cur.fetchall()
    user_columns = [col[0] for col in cur.description]
    users = [dict(zip(user_columns, row)) for row in users_data]

    # Execute second query to fetch data from the 'restaurant' table
    cur.execute('SELECT distinct cuisine_type FROM restaurant')
    restaurant_data = cur.fetchall()
    restaurant_columns = [col[0] for col in cur.description]
    cuisines = [dict(zip(restaurant_columns, row)) for row in restaurant_data]

    return render_template("/customers/index.html", users=users, cuisines=cuisines)

@app.route('/restaurants/<cuisine_type>')
def restaurants_by_cuisine(cuisine_type):
    cur = mysql.connection.cursor()

    # Execute query to fetch restaurants by cuisine type
    cur.execute('SELECT * FROM restaurant WHERE cuisine_type = %s', (cuisine_type,))
    restaurant_data = cur.fetchall()
    restaurant_columns = [col[0] for col in cur.description]
    restaurants = [dict(zip(restaurant_columns, row)) for row in restaurant_data]

    return render_template("/customers/restaurants.html", cuisine_type=cuisine_type, restaurants=restaurants)

@app.route('/restaurants/<cuisine_type>/<restaurant_id>')
def restaurant_menu(restaurant_id, cuisine_type):
    cur = mysql.connection.cursor()
    cur.execute('''
    SELECT *
    FROM food_item 
    JOIN restaurant ON food_item.restaurant_id = restaurant.restaurant_id 
    WHERE restaurant.restaurant_id = %s
    ''', (restaurant_id))
    food_item_data = cur.fetchall()
    food_item_columns = [col[0] for col in cur.description]
    food_items = [dict(zip(food_item_columns, row)) for row in food_item_data]

    cur.execute('''
    SELECT restaurant_name
    from restaurant
    WHERE restaurant.restaurant_id = %s
    ''', (restaurant_id))
    restaurant_name_data = cur.fetchall()
    restaurant_name_columns = [col[0] for col in cur.description]
    restaurant_name = [dict(zip(restaurant_name_columns, row)) for row in restaurant_name_data]

    return render_template("/customers/menu.html",food_items=food_items,restaurant_name=restaurant_name)
if __name__ == '__main__':
    app.run(debug=True)

