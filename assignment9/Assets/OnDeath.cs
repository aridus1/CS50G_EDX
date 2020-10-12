using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class OnDeath : MonoBehaviour
{
	float yPos;
	// Start is called before the first frame update
	void Start()
    {
		
    }

    // Update is called once per frame
    void Update()
    {
		yPos = gameObject.transform.position.y;
		if(yPos < -5)
			SceneManager.LoadScene("GameOver");
	}
}
