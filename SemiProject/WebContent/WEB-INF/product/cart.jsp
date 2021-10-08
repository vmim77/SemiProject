<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<style>

	.cart-page .home_header h2 {
		flex:1;
		text-align: center;
	}
	
	.cart-page .cart_content {
		padding: 0 20px;
		/* border: solid 1px green; */
	}
	
	.home_content h3 {
		font-size: 13px;
		padding-left: 243px;
		margin-bottom: 4px;
	}
	
	.home_content h3 span {
		color: #F05522;
		text-transform: uppercase;
	}
	
	.cart_list li {
		display: flex;
		position: relative;
		margin: auto;
		padding: 20px 180px 20px 180px;
		border-bottom: 1px solid #F5F5F5;
		/* border: solid 1px green; */
	}
	
	.cart_list li:last-child {
		border-bottom: none;
	}
	
	.cart_list li .cart_item_del {
		position: absolute;
		right: 275px;
		top: 25px;
	}
	
	.cart_list li .cart_list_info {
		/* border: solid 1px red; */
		flex: 1;
		margin-left: 20px;
		padding-right: 80px;http://localhost:9090/Subject/index.sh
	}
	
	.cart_list li .cart_list_info > div {
		display: flex;
		justify-content: space-between;
	}
	
	.cart_list li .cart_list_info .size {
		margin-bottom: 8px;
	} 
	
	.cart_list li .cart_list_info label {
		text-transform: uppercase;
		color: #C2C4CA;
		font-size: 12px;
		line-height: 30px;
	}
	
	.cart_list li .cart_list_info select, .cart_list li .cart_list_info input {
		border: none;
		width: 59px;
		height: 30px;
		line-height: 30px;
		border-radius: 4px;
		border: 1px solid #D0D0D0;
		text-align: center;
		box-sizing: border-box;
	}
	
	.cart_list li h4 {
		text-transform: uppercase;
		font-weight: bold;
		margin-bottom: 8px;
	}
	
	.cart_list li h5 {
		font-size: 15px;
		margin-bottom: 15px;
	}
	
	.cart_total {
		padding: 20px 15px;
		background: #f5d5d5;
		margin: 0 270px 0 238px;
	}
	
	.cart_total > div {
		display: flex;
		justify-content: space-between;
	}
	
	.cart_total > div h6 {
		font-size: 13px;
		text-transform: uppercase;
		color: #9b9b9b;
	}
	
	.cart_total > div span {
		font-size: 13px;
	}
	
	.cart_total .total_price span {
		font-size: 18px;
	}
	
	.cart_total .shipping {
		margin-bottom: 20px;
	}
	
	.cart-page form {
		display: flex;
		flex-direction: column;
	}
	
	.cart-page form .cart_content {
		flex: 1;
	}
	
	.cart-page form button {
		/* border: solid 1px red; */
		width: 30%;
		margin: 20px auto auto auto;
		padding-right: 50px;
		text-align: center;
		font-size: 20px;
		font-color: #ffffff;
		/* background-color:#000000; */
	}
	
</style>  


<jsp:include page="/WEB-INF/header.jsp" />

<body>
	<main class="front cart-page">
		<header class="home_header">
			<h2 class="heading5">Outerwear</h2>
			
		</header>
		<div class="home_content">
			<form action="#" >
				<h3>총 <span>4</span>개의 상품이 있습니다.</h3>
				<div class="cart_content">
					
					<ul class="cart_list">
						
						<li>
							<img src="images/product1.jpg" width="150" height="200" alt="product1">
							<div class="cart_list_info">
								<h4>Dubby shoes</h4>
								<h5>20만원</h5>
								<div class="size">
									<label for="size">Size</label>
									<select name="size" id="size">
										<option value="XS">XS</option>
										<option value="S">S</option>
										<option value="M">M</option>
										<option value="L">L</option>
										<option value="XL">XL</option>
									</select>
								</div>
								<div class="qty">
									<label for="quantity">quantity</label>
									<input type="number" min="1" id="quantity">
								</div>
							</div>
							<span class="sprite cart_item_del">삭제</span>
						</li>
						
						<li>
							<img src="images/product1.jpg" width="150" height="200" alt="product1">
							<div class="cart_list_info">
								<h4>Dubby shoes</h4>
									<h5>20만원</h5>
								<div class="size">
									<label for="size">Size</label>
									<select name="size" id="size">
										<option value="XS">XS</option>
										<option value="S">S</option>
										<option value="M">M</option>
										<option value="L">L</option>
										<option value="XL">XL</option>
									</select>
								</div>
								<div class="qty">
									<label for="quantity">quantity</label>
									<input type="number" min="1" id="quantity">
								</div>
							</div>
							<span class="sprite cart_item_del">삭제</span>
						</li>
						
						<li>
							<img src="images/product1.jpg" width="150" height="200" alt="product1">
							<div class="cart_list_info">
								<h4>Dubby shoes</h4>
								<h5>20만원</h5>
								<div class="size">
									<label for="size">Size</label>
									<select name="size" id="size">
										<option value="XS">XS</option>
										<option value="S">S</option>
										<option value="M">M</option>
										<option value="L">L</option>
										<option value="XL">XL</option>
									</select>
								</div>
								<div class="qty">
									<label for="quantity">quantity</label>
									<input type="number" min="1" id="quantity">
								</div> 
							</div>
							<span class="sprite cart_item_del">삭제</span>
						</li>
						
						<li>
							<img src="images/product1.jpg" width="150" height="200" alt="product1">
							<div class="cart_list_info">
								<h4>Dubby shoes</h4>
								<h5>20만원</h5>
								<div class="size">
									<label for="size">Size</label>
									<select name="size" id="size">
										<option value="XS">XS</option>
										<option value="S">S</option>
										<option value="M">M</option>
										<option value="L">L</option>
										<option value="XL">XL</option>
									</select>
								</div>
								<div class="qty">
									<label for="quantity">quantity</label>
									<input type="number" min="1" id="quantity">
								</div>
							</div>
							<span class="sprite cart_item_del">삭제</span>
						</li>
						
					</ul>
				</div>
				<div class="cart_total">
					<div class="shipping">
						<h6>Shipping cost</h6>
						<span class="price">30만원</span>
					</div>
					<div class="total_price">
						<h6>Total price</h6>
						<span class="price">100만원</span>
					</div>
				</div>
				<button class="btn big">주문하기</button>
			</form>
		</div>
	</main>
	
</body>


<jsp:include page="/WEB-INF/footer.jsp" />