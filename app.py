from curses import flash
from datetime import datetime, timedelta
import json
import time
import MySQLdb
from flask import Flask,jsonify,render_template,request,redirect,url_for,session
import flask
import random
from flask_mysqldb import MySQL
# import MySQLdb

app = Flask(__name__,static_url_path="/static")
app.secret_key = 'Top_secret'
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'Enter your password here'
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
                session['agent_ID'] = account['agent_id']
                msg = 'Logged in successfully !'
                flask.flash(msg)
                return redirect(url_for('index_deliveryagent'))
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
                session['restaurant_ID'] = account['restaurant_id']
                msg = 'Logged in successfully !'
                flask.flash(msg)
                return redirect(url_for('restaurant_details'))
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
             # Calculate age from DOB
            dob = datetime.strptime(DOB, '%Y-%m-%d')
            age = (datetime.now() - dob).days // 365

            cur.execute("INSERT INTO customers(customer_id, first_name, middle_name, last_name, dob, age, contact_details, password) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",(ID,firstname,middle_name,lastname,DOB,age,json.dumps({'email': email, 'phone': phone_number}),password))
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
            cur.execute("INSERT INTO Restaurant (password, restaurant_id, restaurant_name, cuisine_type, contact_details, timings, rating) VALUES (%s,%s,%s,%s,%s,%s,%s)",(password,ID,restaurant_name,cuisine_type,json.dumps({'email': email, 'phone': phone_number}),timings,0))
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
        cur.insert("INSERT INTO Delivery_Agent (agent_id, vehicle_number, agent_name, phone_num, email, location, license_id, availability) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",(ID,vehicle_number,firstname +" "+ middle_name +" "+ lastname,phone_number,email,location,password,1))
        mysql.connection.commit()
        flask.flash('Delivery Agent successfully registered')
        return redirect(url_for('login'))
    return render_template("/delivery/signup_deli.html")
    
    
@app.route('/signout')
def signout():
    session.pop('customer_id', None)
    session.pop('restaurant_ID', None)
    session.pop('agent_ID', None)
    session.pop('addr_ID', None)
    session.pop('customerbool', None)
    session.pop('restbool', None)
    session.pop('agentbool', None)
    return redirect(url_for('home'))

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

def fetch_food_item_from_database(item_id):
    cur = mysql.connection.cursor()
    cur.execute('''
        SELECT *
        FROM food_item
        WHERE item_id = %s
    ''', (item_id,))
    food_item_data = cur.fetchall()
    food_item_columns = [col[0] for col in cur.description]
    food_items = [dict(zip(food_item_columns, row)) for row in food_item_data]
    return food_items

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
    ''', (restaurant_id,))
    food_item_data = cur.fetchall()
    food_item_columns = [col[0] for col in cur.description]
    food_items = [dict(zip(food_item_columns, row)) for row in food_item_data]

    cur.execute('''
    SELECT restaurant_name
    from restaurant
    WHERE restaurant.restaurant_id = %s
    ''', (restaurant_id,))
    restaurant_name_data = cur.fetchall()
    restaurant_name_columns = [col[0] for col in cur.description]
    restaurant_name = [dict(zip(restaurant_name_columns, row)) for row in restaurant_name_data]
    # print(food_items)

    return render_template("/customers/menu.html",food_items=food_items,restaurant_name=restaurant_name)

@app.route('/restaurant')
def restaurant_details():
    cur = mysql.connection.cursor()
    restaurant_id = session["restaurant_ID"]
    # Fetch restaurant details
    cur.execute('''
    SELECT *
    FROM restaurant
    WHERE restaurant_id = %s
    ''', (restaurant_id,))
    restaurant_details_data = cur.fetchone()
    restaurant_details_columns = [col[0] for col in cur.description]
    restaurant_details = dict(zip(restaurant_details_columns, restaurant_details_data))

    # Fetch order details
    cur.execute('''
    SELECT
       o.order_id,
       GROUP_CONCAT(oi.item_quantity) AS item_quantities,
       GROUP_CONCAT(oi.notes) AS notes,
       GROUP_CONCAT(fi.item_name) AS item_names,
       SUM(fi.item_price) AS total_price,
       AVG(fi.item_rating) AS avg_food_rating,
       o.order_status,
       o.placed_time,
       o.amount
    FROM orders o
    JOIN ordered_items oi ON o.order_id = oi.order_id
    JOIN food_item fi ON oi.item_id = fi.item_id
    WHERE fi.restaurant_id = %s
    GROUP BY o.order_id;
    ''', (restaurant_id,))
    order_details_data = cur.fetchall()
    order_details_columns = [col[0] for col in cur.description]
    order_details = [dict(zip(order_details_columns, row)) for row in order_details_data]
    

    cur.execute('''
    SELECT *
    FROM food_item 
    JOIN restaurant ON food_item.restaurant_id = restaurant.restaurant_id 
    WHERE restaurant.restaurant_id = %s
    ''', (restaurant_id,))
    food_item_data = cur.fetchall()
    food_item_columns = [col[0] for col in cur.description]
    food_items = [dict(zip(food_item_columns, row)) for row in food_item_data]

    
    return render_template("/restaurants/details.html", restaurant_details=restaurant_details, order_details=order_details,menu=food_items)
@app.route('/restaurant/add_item', methods=['GET', 'POST'])
def add_item():
    if request.method == 'POST':
        # Fetch form data
        item_name = request.form['item_name']
        item_price = float(request.form['item_price'])
        item_type = request.form['item_type']
        vegetarian = True if request.form.get('vegetarian') else False
        availability = True if request.form.get('availability') else False
        restaurant_id = session["restaurant_ID"]
        cursor = mysql.connection.cursor()
        cursor.execute('select max(item_id) from food_item;')
        item_ID = cursor.fetchone()
        item_ID = str(int(item_ID[0]) + 1)
        # order_count = 0
        # Insert food item details into the database
        cur = mysql.connection.cursor()
        cur.execute('''
            INSERT INTO food_item (item_id,item_name, item_price, item_type, vegetarian, availability, restaurant_id)
            VALUES (%s,%s, %s, %s, %s, %s, %s)
        ''', (item_ID, item_name, item_price, item_type, vegetarian, availability, restaurant_id))
        mysql.connection.commit()
        
        # Redirect the user back to the menu page after adding the new item
        return redirect(url_for('restaurant_details'))
    # return render_template('restaurants/details.html')
    else:
        return render_template('restaurants/add_item.html')
@app.route('/delete_item/<item_id>')  
def delete_item(item_id):
    cur = mysql.connection.cursor()
    cur.execute('''
        DELETE FROM food_item
        WHERE item_id = %s
    ''', (item_id,))
    mysql.connection.commit()
    return redirect(url_for('restaurant_details'))

@app.route('/restaurant/editmenu/<item_id>', methods=['GET', 'POST'])
def edit_menu(item_id):
    if request.method == 'POST':
        # Fetch form data
        new_item_name = request.form['item_name']
        new_item_price = float(request.form['item_price'])
        new_item_type = request.form['item_type']
        new_vegetarian = True if request.form.get('vegetarian') else False
        new_availability = True if request.form.get('availability') else False
        
        # Update food item details in the database
        cur = mysql.connection.cursor()
        cur.execute('''
            UPDATE food_item
            SET item_name = %s, item_price = %s, item_type = %s, vegetarian = %s, availability = %s
            WHERE item_id = %s
        ''', (new_item_name, new_item_price, new_item_type, new_vegetarian, new_availability, item_id))
        mysql.connection.commit()
        
        # Redirect the user back to the menu page after editing
        return redirect(url_for('restaurant_details'))  # Assuming 'menu' is the route for displaying the menu
    else:
        # Fetch the details of the food item with the given item_id from the database
        food_item = fetch_food_item_from_database(item_id)
        return render_template('restaurants/edit_menu.html', food_item=food_item)

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
    JOIN Address ON customer_address.address_id = Address.address_id
    WHERE customer_address.customer_id = %s
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
    
        print(orders)
    contact_details = json.loads(user[0]['contact_details'])
    return render_template("/customers/userdetails.html", user=user, address=address, orders=orders, food_items=food_items, phone = contact_details.get('phone'), email = contact_details.get('email'))

@app.route('/ordersummary', methods=['GET', 'POST'])
def ordersummary():
    rest_id = request.args.get('rest_id')
    payment_method = request.args.get('payment_method')
    payment_status = request.args.get('payment_status')
    ordered_items = json.loads(request.args.get('ordered_items'))
    customer_id = session["customer_id"]
    order_status = "Processing"
    placed_time = datetime.now()
    amount =0
    for item in ordered_items:
        item_ID = item["item_id"]
        item_quantity = item["item_quantity"]
        notes = item["notes"]
        item_price = item['item_price']
        if (item_quantity != "0"):
            amount += item_price * int(item_quantity)
    cursor = mysql.connection.cursor()
    cursor.execute('select max(order_id) from Orders;')
    order_ID = cursor.fetchone()
    order_ID = str(int(order_ID[0]) + 1)
    cursor.execute('select max(payment_id) from Payment;')
    payment_ID = cursor.fetchone()
    payment_ID = str(int(payment_ID[0]) + 1)
    cursor.execute('select max(agent_id) from delivery_agent')
    num_delivery_agents = cursor.fetchone()
    agent_id = random.randint(1, int(num_delivery_agents[0]))
    cursor.execute('insert into payment (payment_id, payment_method, payment_status, amount, time) values (%s, %s, %s, %s, %s);', (payment_ID, payment_method, payment_status, amount, placed_time))
    cursor.execute('insert into orders (order_id, customer_id,restaurant_id, payment_id, order_status, placed_time, amount) values (%s, %s,%s, %s, %s, %s, %s);', (order_ID, customer_id,rest_id, payment_ID, order_status, placed_time, amount))
    cursor.execute('insert into delivery (order_id, agent_id,customer_id, restaurant_id, delivery_review, delivery_rating, delivery_charges, pickup_time, delivery_time, delivery_status,tip) values (%s, %s,%s, %s, %s, %s, %s,%s, %s,%s, %s);', (order_ID,agent_id, customer_id,rest_id, "", random.randint(1, 5), random.randint(1, 9),datetime.now(),datetime.now()+timedelta(minutes=30),"Placed",random.randint(1, 5)))
    # ordered_items is list of dictionaries where each dictionary contains item_id, item_quantity, notes, item_price
    for item in ordered_items:
        item_ID = item["item_id"]
        item_quantity = item["item_quantity"]
        notes = item["notes"]
        item_price = item['item_price']
        if (item_quantity != "0"):
            cursor.execute('update food_item set order_count = order_count + 1 where item_id = %s;', (item_ID,))
            cursor.execute('insert into ordered_items (order_id, item_id, item_quantity, item_rating, item_review, notes) values (%s, %s, %s, %s, %s, %s);', (order_ID, item_ID, item_quantity, 4, None, notes))
            mysql.connection.commit()
   
    # cursor.execute("select name from restaurant where restaurant_ID = %s;", (str(rest_id),))
    # rest_name = cursor.fetchone()[0]
    cursor.close()
    # flash("Order successfully submitted.")
    return redirect(url_for('userdetails'))

@app.route('/delivery_dashboard', methods=['GET', 'POST'])
def index_deliveryagent():
    agent_id = session.get('agent_ID')
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Delivery WHERE agent_id = %s", (agent_id,))
    delivery_data = cur.fetchall()
    delivery_data_columns = [col[0] for col in cur.description]
    delivery = [dict(zip(delivery_data_columns, row)) for row in delivery_data]
    for delivery_item in delivery:
        # Fetch customer address
        customer_id = delivery_item['customer_id']
        cur.execute("SELECT a.building_name, a.street, a.pin_code, a.city, a.state FROM Customer_Address ca JOIN Address a ON ca.address_id = a.address_id WHERE ca.customer_id = %s", (customer_id,))
        customer_address_data = cur.fetchone()
        if customer_address_data:
            customer_address = {
                'building_name': customer_address_data[0],
                'street': customer_address_data[1],
                'pin_code': customer_address_data[2],
                'city': customer_address_data[3],
                'state': customer_address_data[4]
            }
        else:
            customer_address = None
        delivery_item['customer_address'] = customer_address
        
        # Fetch restaurant details
        restaurant_id = delivery_item['restaurant_id']
        cur.execute("SELECT a.building_name, a.street, a.pin_code, a.city, a.state FROM restaurant_address r JOIN Address a ON r.address_id = a.address_id WHERE r.restaurant_id = %s", (restaurant_id,))
        restaurant_address_data = cur.fetchone()
        if restaurant_address_data:
            restaurant_address = {
                'building_name': restaurant_address_data[0],
                'street': restaurant_address_data[1],
                'pin_code': restaurant_address_data[2],
                'city': restaurant_address_data[3],
                'state': restaurant_address_data[4]
            }
        else:
            restaurant_address = None
        delivery_item['restaurant_address'] = restaurant_address

        agent_id = session.get('agent_ID')
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM Delivery_Agent WHERE agent_id = %s", (agent_id,))
        agent_data = cur.fetchall()
        agent_columns = [col[0] for col in cur.description]
        agent = [dict(zip(agent_columns, row)) for row in agent_data][0] 
    return render_template('delivery/index.html', delivery=delivery, agent = agent)
    # return render_template('delivery/index.html', delivery=delivery)

# @app.route('/aboutus')
# def aboutus():
#     # You can render the aboutus.html template here
#     return render_template('aboutus.html')

@app.route('/aboutus', methods=["GET", "POST"])
def aboutus():
    if (request.method=="POST"):
        cur = mysql.connection.cursor()
        old_col_name =str( request.values.get("col_name"))
        new_name =str( request.values.get("new_name"))
        if (new_name != ""):
            sql_query = f"ALTER TABLE `team_details` RENAME COLUMN `{old_col_name}` TO `{new_name}`;"
            cur.execute(sql_query)
            mysql.connection.commit()
            cur.close()
            flask.flash("Successfully renamed the column")
        else:
            flask.flash("Please put up rename value of the column.")
    sql_query = "SELECT column_name FROM information_schema.columns WHERE table_name = %s"
    tablename = 'team_details'  
    cur = mysql.connection.cursor()
    cur.execute(sql_query, ("team_details",))
    col_names = cur.fetchall()

    table ={'col1':col_names[4][0],'col2':col_names[5][0],'col3':col_names[6][0],'col4':col_names[7][0],}
    sql_query = f"SELECT `{table['col1']}`, `{table['col2']}`, `{table['col3']}`, `{table['col4']}` FROM `team_details`;"
    cur.execute(sql_query)
    students = cur.fetchall()
    student_details=[]
    for student in students:
        temp = {
            'col1':student[0],
            'col2':student[1],
            'col3':student[2],
            'col4':student[3]
        }
        student_details.append(temp)
    
    return render_template('aboutus.html',tablename=tablename, table = table, student_details= student_details)

if __name__ == '__main__':
    app.run(debug=True)

