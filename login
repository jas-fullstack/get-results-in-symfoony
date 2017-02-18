<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Session\Session;

class LoginController extends Controller
{
    /**
     * @Route("/login", name="login")
     */
    public function indexAction(Request $request)
    {
		
		$em = $this->getDoctrine()->getManager(); // ...or getEntityManager() prior to Symfony 2.1
		$connection = $em->getConnection();
		$statement = $connection->prepare("SELECT * FROM blog_post");
		$statement->execute();
		$results = $statement->fetchAll();
		
        return $this->render('admin/index.html.twig');
    }
	/**
     * @Route("/login/chklogin", name="ckhlogin")
     */
	public function chklogin(Request $request)
	{
		$session = new Session();
       // $session->start();
		$session->set('name', 'Drakdfd');
		
		
		$em = $this->getDoctrine()->getManager(); // ...or getEntityManager() prior to Symfony 2.1
		$connection = $em->getConnection();
		$statement = $connection->prepare("SELECT * FROM adminlogin where email='".$_POST['email']."' AND pass='".$_POST['pass']."'");
		$statement->execute();
		$results = $statement->fetchAll();
		//print_r($results);
		if(empty($results))
		{
			$this->addFlash('notice', 'not login');
		}
		else
		{
			$this->addFlash('notice', 'sucess login');
		}
		 
		return $this->render('admin/index.html.twig');
	}
}
