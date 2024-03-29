import time
import MySQLdb
from flask import Flask,jsonify,render_template,request,redirect,url_for,session
import flask
from flask_mysqldb import MySQL
# import MySQLdb

app = Flask(__name__,static_url_path="/static")
app.secret_key = 'Top_secret'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = '*********'
app.config['MYSQL_DB'] = 'food_delivery_system'
mysql = MySQL(app)
# try:
#     mysql.connection.ping(reconnect=True)
# except MySQLdb.Error as e:
#     print(f"Error connecting to MySQL: {e}")
#     # Handle error accordingly, maybe retry connection or exit the application




# login for all
@app.route('/login',methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'useremail' in request.form and 'password' in request.form and 'authority' in request.form:
        useremail = request.form['useremail']
        password = request.form['password']
        authority = request.form['authority']
        session['addr_ID'] = None
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        if (authority == "Customer"):
            if("'" in useremail):
                msg = "Single Quote (') is not allowed in username field."
                flask.flash(msg)
                return redirect(url_for('login'))
            cursor.execute("SELECT * FROM Customers WHERE contact_details->>'$.email' = %s AND password = %s", (useremail, password,))
            account = cursor.fetchone()
            if account:
                session['customerbool'] = True
                session['restbool'], session['agentbool'] = False, False
                session['customer_id'] = str(account['customer_id'])
                cursor.execute("select address_ID from customer_address where customer_id=%s", (session['customer_id'],))
                addr_ID = cursor.fetchall()
                session['addr_ID'] = addr_ID[0]
                msg = 'Logged in successfully !'
                flask.flash(msg)
                return redirect(url_for('index'))
            else:
                time.sleep(2)
                msg = 'Incorrect username / password !'
        elif (authority == "Delivery Agent"):
            cursor.execute("SELECT * FROM delivery_agent WHERE email = %s AND password = %s", (useremail, password, ))
            account = cursor.fetchone()
            if account:
                session['agentbool'] = True
                session['cutomerbool'], session['restbool'] = False, False
                session['agent_ID'] = account['agent_ID']
                msg = 'Logged in successfully !'
                flask.flash(msg)
                return redirect(url_for('delivery.agentdetail'))
            else:
                time.sleep(2)
                msg = 'Incorrect username / password !'
        elif (authority == "Restaurant"):
            cursor.execute("SELECT * FROM Restaurant WHERE contact_details->>'$.email' = %s AND password = %s", (useremail, password, ))
            # cursor.execute(f"SELECT * FROM restaurant WHERE email='{useremail}' AND password='{password}'")
            account = cursor.fetchone()
            if account:
                session['restbool'] = True
                session['agentbool'], session['customerbool'] = False, False
                session['restaurant_ID'] = account['restaurant_ID']
                msg = 'Logged in successfully !'
                flask.flash(msg)
                return redirect(url_for('restaurant.restdetail'))
            else:
                time.sleep(2)
                msg = 'Incorrect username / password !'
        else:
            time.sleep(2)
            msg = 'Incorrect username / password !'
        flask.flash(msg)
    return render_template('login.html', msg = msg)

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    return render_template('signup.html')

@app.route('/signupcustomer',methods=['GET', 'POST'])
def signupcustomer():
    if request.method == 'POST':
        userdetails = request.form
        firstname = userdetails['firstname']
        middle_name = userdetails['middlename']
        lastname = userdetails['lastname']
        email = userdetails['email']
        DOB = userdetails['DOB']
        phone_number = userdetails['phone_number']
        password = userdetails['password']
        building_name = userdetails['building_name']
        street_name = userdetails['street_name']
        city = userdetails['cityname']
        state = userdetails['statename']
        pin_code = userdetails['pincode']
        cur = mysql.connection.cursor()
        cur.execute("select max(customer_id) from customers")
        ID = cur.fetchone()
        ID = str(int(ID[0]) + 1)
        cur.execute("SELECT * FROM Address WHERE building_name=%s and street=%s and city=%s and state=%s and pin_code=%s",(building_name,street_name,city,state,pin_code))
        address_ID = cur.fetchone()
        try:
            if address_ID is None:
                cur.execute("select max(address_id) from Address")
                address_ID = cur.fetchone()
                address_ID = str(int(address_ID[0]) + 1)
                cur.execute("INSERT INTO Address (address_id, building_name, street, pin_code, city, state) VALUES (%s,%s,%s,%s,%s,%s)",(address_ID,building_name,street_name,pin_code,city,state))
            else:
                address_ID = address_ID[0]
            cur.execute("INSERT INTO customers(customer_id, first_name, middle_name, last_name, dob, age, contact_details, password) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",(ID,firstname,middle_name,lastname,DOB,26,{email,phone_number},password))
            cur.execute("INSERT INTO Customer_Address (customer_id, address_id) VALUES (%s,%s)",(ID,address_ID))
            mysql.connection.commit()
        except:
            mysql.connection.rollback()
        finally:
            cur.close()
        mysql.connection.commit()
        flask.flash('Customer successfully registered')
        return redirect(url_for('login'))
    return render_template("/customers/signup_user.html")


@app.route('/signuprestaurants',methods=['GET', 'POST'])
def signuprestaurants():
    if request.method == 'POST':
        userdetails = request.form
        restaurant_name = userdetails['restaurant_name']
        cuisine_type = userdetails['cuisine_type']
        email = userdetails['email']
        phone_number = userdetails['phone_number']
        password = userdetails['password']
        building_name = userdetails['building_name']
        street_name = userdetails['street_name']
        city = userdetails['cityname']
        state = userdetails['statename']
        pin_code = userdetails['pincode']
        timings = userdetails['timing']
        cur = mysql.connection.cursor()
        cur.execute("select max(restaurant_id) from Restaurant")
        ID = cur.fetchone()
        ID = str(int(ID[0]) + 1)
        cur.execute("SELECT * FROM Address WHERE building_name=%s and street=%s and city=%s and state=%s and pin_code=%s",(building_name,street_name,city,state,pin_code))
        address_ID = cur.fetchone()
        try:
            if address_ID is None:
                cur.execute("select max(address_id) from Address")
                address_ID = cur.fetchone()
                address_ID = str(int(address_ID[0]) + 1)
                cur.execute("INSERT INTO Address (address_id, building_name, street, pin_code, city, state) VALUES (%s,%s,%s,%s,%s,%s)",(address_ID,building_name,street_name,pin_code,city,state))
            else:
                address_ID = address_ID[0]
            cur.execute("INSERT INTO Restaurant (password, restaurant_id, restaurant_name, cuisine_type, contact_details, timings, rating) VALUES (%s,%s,%s,%s,%s,%s,%s)",(password,ID,restaurant_name,cuisine_type,email + phone_number,timings,0))
            cur.execute("INSERT INTO Restaurant_Address (restaurant_id, address_id) VALUES (%s,%s)",(ID,address_ID))
            mysql.connection.commit()
        except:
            mysql.connection.rollback()
        finally:
            cur.close()
        mysql.connection.commit()
        flask.flash('Restaurant successfully registered')
        return redirect(url_for('login'))
    return render_template("/restaurants/signup_restaurant.html")

# as a delivery person
@app.route('/signupdelivery',methods=['GET', 'POST'])
def signupdelivery():
    if request.method == 'POST':
        userdetails = request.form
        firstname = userdetails['firstname']
        middle_name = userdetails['middlename']
        lastname = userdetails['lastname']
        email = userdetails['email']
        DOB = userdetails['DOB']
        vehicle_number = userdetails['vehicle_number']  
        phone_number = userdetails['phone_number']
        password = userdetails['password']
        location = userdetails['location']
        cur = mysql.connection.cursor()
        cur.execute("select max(agent_id) from Delivery_Agent")
        ID = cur.fetchone()
        ID = str(int(ID[0]) + 1)
        cur.insert("INSERT INTO Delivery_Agent (agent_id, vehicle_number, agent_name, phone_num, email, location, license_id, availability) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",(ID,vehicle_number,firstname + middle_name + lastname,phone_number,email,location,password,1))
        mysql.connection.commit()
        flask.flash('Delivery Agent successfully registered')
        return redirect(url_for('login'))
    return render_template("/delivery/signup_deli.html")
    
    
@app.route('/')
def home():
    return render_template('home.html')

@app.route('/dashboard')
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
    print(food_items)

    return render_template("/customers/menu.html",food_items=food_items,restaurant_name=restaurant_name)

@app.route('/userdetails')
# should contain some details of the user like account details, address, and orders made by the user
def userdetails():
    customer_id = session.get('customer_id')
    cur = mysql.connection.cursor()
    cur.execute('''
    SELECT *
    FROM Customers
    WHERE customer_id = %s
    ''', (customer_id,))
    user_data = cur.fetchall()
    user_columns = [col[0] for col in cur.description]
    user = [dict(zip(user_columns, row)) for row in user_data]

    cur.execute('''
    SELECT *
    FROM customer_address
    WHERE customer_id = %s
    ''', (customer_id,))
    address_data = cur.fetchall()
    address_columns = [col[0] for col in cur.description]
    address = [dict(zip(address_columns, row)) for row in address_data]

    cur.execute('''
    SELECT *
    FROM Orders
    WHERE customer_id = %s
    ''', (customer_id,))
    order_data = cur.fetchall()
    order_columns = [col[0] for col in cur.description]
    orders = [dict(zip(order_columns, row)) for row in order_data]

    order_ids = [order['order_id'] for order in orders]

    # once you have order_id we see the relation Ordered_items (order_id, item_id, item_quantity, item_rating, item_review, notes)
    # this relation is many to many relations between orders and food_items
    # so for one order_id we can have multiple food_items
    # by order_id we get item_id and then we can get the food_item details from food_item table

    food_items = []  # list of dictionaries which contain order_id and food_items corresponding to that order_id
    for order_id in order_ids:
        cur.execute('''
        SELECT *
        FROM Ordered_items
        WHERE order_id = %s
        ''', (order_id,))
        ordered_items_data = cur.fetchall()
        ordered_items_columns = [col[0] for col in cur.description]
        ordered_items = [dict(zip(ordered_items_columns, row)) for row in ordered_items_data]

        for item in ordered_items:
            cur.execute('''
            SELECT *
            FROM food_item
            WHERE item_id = %s
            ''', (item['item_id'],))
            food_item_data = cur.fetchall()
            food_item_columns = [col[0] for col in cur.description]
            food_item = [dict(zip(food_item_columns, row)) for row in food_item_data]
            food_items.append({'order_id': order_id, 'food_item': food_item[0]})

    return render_template("/customers/userdetails.html", user=user, address=address, orders=orders, food_items=food_items)


if __name__ == '__main__':
    app.run(debug=True)

