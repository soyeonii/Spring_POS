package com.example.demo;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {
	@Autowired
	private ProductDao productDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private SaleDao saleDao;
	@Autowired
	private ReceiveDao receiveDao;

	@GetMapping("/sale")
	public String sale(Model model) {
		model.addAttribute("products", productDao.selectAll());
		model.addAttribute("count", productDao.count());
		return "sale";
	}

	@GetMapping("/addCart")
	public String addCart(Model model, @RequestParam(value = "code") String code) {
		model.addAttribute("product", productDao.selectByCode(code).get(0));
		return "addCart";
	}

	@GetMapping("/deleteCart")
	public String deleteCart(Model model, @RequestParam(value = "cartId") String cartId) {
		return "deleteCart";
	}

	@GetMapping("/stock")
	public String stock(Model model) {
		model.addAttribute("products", productDao.selectAll());
		return "stock";
	}

	@GetMapping("/receivedHistory")
	public String receivedHistory(Model model) {
		model.addAttribute("receives", receiveDao.selectAll());
		return "receivedHistory";
	}

	@GetMapping("/statistic")
	public String statistic(Model model, @RequestParam(value = "period", required = false) String period) {
		List<Sale> sales = saleDao.getTotalByDate();
		for (Sale sale : sales) {
			model.addAttribute(sale.getSaleDate(), String.valueOf(sale.getPrice()));
		}
		if (period != null) {
			model.addAttribute("total", saleDao.getSum(period));
			List<Sale> bests = saleDao.getBest(period);
			model.addAttribute("bests", bests);
		}
		return "statistic";
	}

	@GetMapping("/myPage")
	public String myPage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		User user = userDao.selectById(id);
		model.addAttribute("name", user.getName());
		model.addAttribute("email", user.getEmail());
		return "myPage";
	}

	@GetMapping("/withdrawal")
	public String withdrawal(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		userDao.delete(id);
		return "withdrawal";
	}

	@GetMapping("/orderConfirmation")
	public String orderConfirmation(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
		ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("cartlist");
		if (products != null) {
			Sale sale = new Sale();
			sale.setNumber(saleDao.getNumber());
			for (Product product : products) {
				sale.setCode(product.getCode());
				sale.setPrice(product.getPrice());
				sale.setCount(product.getQuantity());
				saleDao.insert(sale);
				product.setUnitsInStock(product.getUnitsInStock() - product.getQuantity());
				productDao.update(product);
			}
		}
		return "orderConfirmation";
	}

	@GetMapping("/addProduct")
	public String addProduct(Model model, @RequestParam(value = "p_code", required = false) String code,
			@RequestParam(value = "p_name", required = false) String name,
			@RequestParam(value = "p_price", required = false) String price,
			@RequestParam(value = "p_unitsInStock", required = false) String unitsInStock,
			@RequestParam(value = "p_manufacturer", required = false) String manufacturer) {
		if (!code.equals("") && !name.equals("") && !price.equals("") && !unitsInStock.equals("")
				&& !manufacturer.equals("")) {
			List<Product> products = productDao.selectByCode(code);
			Product product;
			if (!products.isEmpty()) {
				product = products.get(0);
				if (product.getName().equals(name) && product.getPrice() == Integer.valueOf(price)
						&& product.getManufacturer().equals(manufacturer)) {
					product.setUnitsInStock(product.getUnitsInStock() + Integer.valueOf(unitsInStock));
					productDao.update(product);
				}
			} else {
				product = new Product();
				product.setCode(code);
				product.setName(name);
				product.setPrice(Integer.valueOf(price));
				product.setUnitsInStock(Integer.valueOf(unitsInStock));
				product.setManufacturer(manufacturer);
				productDao.insert(product);
			}
			product.setUnitsInStock(Integer.valueOf(unitsInStock));
			receiveDao.insert(product);
		}
		return "addProduct";
	}

	@GetMapping("/updatePrice")
	public String updatePrice(Model model, @RequestParam(value = "p_code", required = false) String code,
			@RequestParam(value = "p_price", required = false) String price) {
		if (!code.equals("") && !price.equals("")) {
			Product product = productDao.selectByCode(code).get(0);
			if (product != null) {
				product.setPrice(Integer.valueOf(price));
				productDao.update(product);
			}
		}
		return "updatePrice";
	}

	@GetMapping("/deleteProduct")
	public String deleteProduct(Model model, @RequestParam(value = "p_code", required = false) String code) {
		if (!code.equals(""))
			productDao.delete(code);
		return "deleteProduct";
	}

	@GetMapping("/searchProduct")
	public String searchProduct(Model model, @RequestParam(value = "p_code", required = false) String code) {
		if (!code.equals("")) {
			model.addAttribute("products", productDao.selectByCode(code));
		} else {
			model.addAttribute("products", productDao.selectAll());
		}
		return "stock";
	}

	@GetMapping("/signIn")
	public String signIn(Model model) {
		return "signIn";
	}

	@GetMapping("/processSignIn")
	public String processSignIn(Model model, @RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "password", required = false) String password) {
		if (!id.equals("") && !password.equals("")) {
			User user = userDao.selectById(id);
			if (user != null)
				if (user.getPassword().equals(password))
					model.addAttribute("id", id);
		}
		return "processSignIn";
	}

	@GetMapping("/logout")
	public String logout(Model model) {
		return "logout";
	}

	@GetMapping("/modify")
	public String modify(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		User user = userDao.selectById(id);
		model.addAttribute("password", user.getPassword());
		model.addAttribute("name", user.getName());
		model.addAttribute("email", user.getEmail());
		return "modify";
	}

	@GetMapping("/processModify")
	public String processModify(Model model, HttpServletRequest request,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "password", required = false) String password,
			@RequestParam(value = "email", required = false) String email) {
		if (!name.equals("") && !password.equals("") && !email.equals("")) {
			HttpSession session = request.getSession();
			String id = (String) session.getAttribute("id");
			User user = new User(id, password);
			user.setName(name);
			user.setEmail(email);
			userDao.update(user);
		}
		return "processModify";
	}

	@GetMapping("/signUp")
	public String signUp(Model model) {
		return "signUp";
	}

	@GetMapping("/processSignUp")
	public String signUp(Model model, @RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "password", required = false) String password) {
		User user = new User(id, password);
		user.setName(name);
		user.setEmail(email);
		userDao.insert(user);
		return "signIn";
	}

	@GetMapping("/salesHistory")
	public String salesHistory(Model model) {
		model.addAttribute("historys", saleDao.selectAll());
		return "salesHistory";
	}

	@GetMapping("/deleteSale")
	public String deleteSale(Model model, @RequestParam(value = "number") String number) {
		List<Sale> sales = saleDao.selectByNumber(number);
		for (Sale sale : sales) {
			Product product = productDao.selectByCode(sale.getCode()).get(0);
			product.setUnitsInStock(product.getUnitsInStock() + sale.getCount());
			productDao.update(product);
		}
		saleDao.delete(number);
		return "deleteSale";
	}
}